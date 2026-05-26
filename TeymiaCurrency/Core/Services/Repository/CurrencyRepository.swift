import Foundation

protocol CurrencyRepositoryProtocol: Sendable {
    func observeSelectedCurrencies() -> AsyncStream<[Currency]>
    func fetchAllCurrencies() async throws -> [Currency]
    func getLatestRates(for currencies: [Currency], baseCurrency: String) async throws -> [String: Double]
    func saveSelectedCurrencies(_ currencies: [Currency]) async
}

final class CurrencyRepository: CurrencyRepositoryProtocol, @unchecked Sendable {
    private let apiClient: CurrencyAPIClientProtocol
    private let storage: CurrencyStorageProtocol
    private let staticDataProvider: CurrencyStaticDataProviderProtocol
    private let lock = NSRecursiveLock()

    private var selectedCurrenciesContinuation: AsyncStream<[Currency]>.Continuation?
    private lazy var selectedCurrenciesStream: AsyncStream<[Currency]> = {
        AsyncStream { continuation in
            self.lock.lock()
            self.selectedCurrenciesContinuation = continuation
            continuation.yield(self.currentSelected)
            self.lock.unlock()
        }
    }()

    private var currentSelected: [Currency] = [] {
        didSet {
            lock.lock()
            selectedCurrenciesContinuation?.yield(currentSelected)
            lock.unlock()
        }
    }

    init(
        apiClient: CurrencyAPIClientProtocol,
        storage: CurrencyStorageProtocol,
        staticDataProvider: CurrencyStaticDataProviderProtocol = LocalJSONCurrencyProvider()
    ) {
        self.apiClient = apiClient
        self.storage = storage
        self.staticDataProvider = staticDataProvider
        self.currentSelected = storage.loadSelectedCurrencies() ?? []
    }

    func observeSelectedCurrencies() -> AsyncStream<[Currency]> {
        return selectedCurrenciesStream
    }

    func fetchAllCurrencies() async throws -> [Currency] {
        try await staticDataProvider.loadInitialCurrencies()
    }

    func saveSelectedCurrencies(_ currencies: [Currency]) async {
        self.currentSelected = currencies
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
}
