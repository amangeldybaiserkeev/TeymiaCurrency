import Foundation
import os

protocol CurrencyRepositoryProtocol: Sendable {
    func observeSelectedCurrencies() -> AsyncStream<[Currency]>
    func fetchAllCurrencies() async throws -> [Currency]
    func getLatestRates(for currencies: [Currency], baseCurrency: String) async throws -> [String: Double]
    func saveSelectedCurrencies(_ currencies: [Currency]) async
}

final class CurrencyRepository: CurrencyRepositoryProtocol, Sendable {
    private let apiClient: CurrencyAPIClientProtocol
    private let storage: CurrencyStorageProtocol
    private let fiatProvider: FiatCurrencyProviderProtocol
    private let selectedCurrenciesStream: AsyncStream<[Currency]>
    private let stateLock = OSAllocatedUnfairLock(initialState: RepositoryState())

    private struct RepositoryState {
        var currentSelected: [Currency] = []
        var cachedCryptoList: [Currency] = []
        var continuation: AsyncStream<[Currency]>.Continuation?
    }

    init(
        apiClient: CurrencyAPIClientProtocol,
        storage: CurrencyStorageProtocol,
        fiatProvider: FiatCurrencyProviderProtocol = FiatCurrencyProvider()
    ) {
        self.apiClient = apiClient
        self.storage = storage
        self.fiatProvider = fiatProvider

        let (stream, continuation) = AsyncStream<[Currency]>.makeStream()
        self.selectedCurrenciesStream = stream

        let initialSelected = storage.loadSelectedCurrencies() ?? []
        self.stateLock.withLock { state in
            state.currentSelected = initialSelected
            state.continuation = continuation
            continuation.yield(initialSelected)
        }
    }

    func observeSelectedCurrencies() -> AsyncStream<[Currency]> {
        return selectedCurrenciesStream
    }

    func fetchAllCurrencies() async throws -> [Currency] {
        async let fiatTask = fiatProvider.loadInitialCurrencies()
        async let cryptoTask = fetchTopCryptoCurrencies()

        let (fiats, cryptos) = try await (fiatTask, cryptoTask)
        return fiats + cryptos
    }

    func saveSelectedCurrencies(_ currencies: [Currency]) async {
        stateLock.withLock { state in
            state.currentSelected = currencies
            state.continuation?.yield(currencies)
        }
        storage.saveSelectedCurrencies(currencies)
    }

    func getLatestRates(for currencies: [Currency], baseCurrency: String) async throws -> [String: Double] {
        let fiatCodes = currencies.filter { $0.type == .fiat }.map { $0.code }
        let cryptoIds = currencies.filter { $0.type == .crypto }.map { $0.coinGeckoId ?? $0.code.lowercased() }

        if let cached = storage.loadRatesCache(), abs(cached.timestamp.timeIntervalSinceNow) < 300 {
            return cached.rates
        }

        return try await withThrowingTaskGroup(of: [String: Double].self) { group in
            if !fiatCodes.isEmpty {
                group.addTask {
                    let allFiat = try await self.apiClient.fetchFiatRates(base: baseCurrency)
                    return allFiat.filter { fiatCodes.contains($0.key) }
                }
            }

            if !cryptoIds.isEmpty {
                group.addTask {
                    let cryptoRatesById = try await self.apiClient.fetchCryptoRates(ids: cryptoIds, vsCurrency: baseCurrency)
                    var cryptoRatesByCode: [String: Double] = [:]
                    for currency in currencies where currency.type == .crypto {
                        let id = currency.coinGeckoId ?? currency.code.lowercased()
                        if let price = cryptoRatesById[id] {
                            cryptoRatesByCode[currency.code] = price
                        }
                    }
                    return cryptoRatesByCode
                }
            }

            var combinedRates: [String: Double] = [baseCurrency: 1.0]
            for try await rates in group {
                combinedRates.merge(rates) { _, new in new }
            }

            let cache = CachedRates(timestamp: Date(), rates: combinedRates)
            self.storage.saveRatesCache(cache)

            return combinedRates
        }
    }

    private func fetchTopCryptoCurrencies() async -> [Currency] {
        // 1. Проверяем оперативную память (In-Memory Cache)
        let memoryCached = stateLock.withLock { $0.cachedCryptoList }
        if !memoryCached.isEmpty {
            return memoryCached
        }

        // 2. Проверяем постоянный диск (Disk Cache) на случай, если приложение только открылось
        let diskCached = storage.loadDownloadedCrypto() ?? []

        do {
            // 3. Пробуем обновить данные из сети
            let marketDataList = try await apiClient.fetchTopCryptoList(vsCurrency: "usd", perPage: 100)

            let freshCryptos = marketDataList.map { marketData in
                Currency(
                    code: marketData.symbol.uppercased(),
                    name: marketData.name,
                    type: .crypto,
                    iconUrlString: marketData.image,
                    coinGeckoId: marketData.id
                )
            }

            // 4. Если всё успешно — обновляем и память, и диск
            stateLock.withLock { state in
                state.cachedCryptoList = freshCryptos
            }
            storage.saveDownloadedCrypto(freshCryptos)

            return freshCryptos

        } catch {
            // 5. Сеть упала или сработал Rate Limit?
            // Вместо краша или print() плавно возвращаем то, что было на диске.
            // Если это самый первый запуск и дисковый кэш пуст — вернется пустой массив, UI не сломается.
            if !diskCached.isEmpty {
                stateLock.withLock { state in
                    state.cachedCryptoList = diskCached
                }
                return diskCached
            }

            return []
        }
    }
}
