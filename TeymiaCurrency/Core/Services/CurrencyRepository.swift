import Foundation

protocol CurrencyRepositoryProtocol: Sendable {
    func getLatestRates(for currencies: [Currency], baseCurrency: String) async throws -> [String: Double]
    func loadSelectedCurrencies() -> [Currency]
    func saveSelectedCurrencies(_ currencies: [Currency])
}

final class CurrencyRepository: CurrencyRepositoryProtocol {
    private let apiClient: CurrencyAPIClientProtocol
    private let storage: CurrencyStorageProtocol

    init(apiClient: CurrencyAPIClientProtocol, storage: CurrencyStorageProtocol) {
        self.apiClient = apiClient
        self.storage = storage
    }

    func loadSelectedCurrencies() -> [Currency] {
        return storage.loadSelectedCurrencies() ?? defaultCurrencies
    }

    func saveSelectedCurrencies(_ currencies: [Currency]) {
        storage.saveSelectedCurrencies(currencies)
    }

    func getLatestRates(for currencies: [Currency], baseCurrency: String) async throws -> [String: Double] {
        let fiatCodes = currencies.filter { $0.type == .fiat }.map { $0.code }
        let cryptoCodes = currencies.filter { $0.type == .crypto }.map { $0.code }

        return try await withThrowingTaskGroup(of: [String: Double].self) { group in

            // 1. Запрос фиатных рейтов
            if !fiatCodes.isEmpty {
                group.addTask {
                    let allFiat = try await self.apiClient.fetchFiatRates(base: baseCurrency)
                    return allFiat.filter { fiatCodes.contains($0.key) }
                }
            }

            // 2. Запрос крипто рейтов
            if !cryptoCodes.isEmpty {
                group.addTask {
                    return try await self.apiClient.fetchCryptoRates(codes: cryptoCodes, vsCurrency: baseCurrency)
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

    private var defaultCurrencies: [Currency] {
        return [
            Currency(code: "USD", name: "US Dollar", type: .fiat, symbol: "$"),
            Currency(code: "EUR", name: "Euro", type: .fiat, symbol: "€"),
            Currency(code: "BTC", name: "Bitcoin", type: .crypto, symbol: "₿")
        ]
    }
}
