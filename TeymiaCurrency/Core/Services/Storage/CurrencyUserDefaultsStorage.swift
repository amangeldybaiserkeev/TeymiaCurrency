import Foundation

protocol CurrencyStorageProtocol: Sendable {
    func saveSelectedCurrencies(_ currencies: [Currency])
    func loadSelectedCurrencies() -> [Currency]?
    func saveRatesCache(_ cache: CachedRates)
    func loadRatesCache() -> CachedRates?
}

final class CurrencyUserDefaultsStorage: CurrencyStorageProtocol, @unchecked Sendable {
    private let userDefaults: UserDefaults
    private let currenciesKey = "com.app.selectedCurrencies"
    private let ratesCacheKey = "com.app.ratesCache"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveSelectedCurrencies(_ currencies: [Currency]) {
        if let data = try? JSONEncoder().encode(currencies) {
            userDefaults.set(data, forKey: currenciesKey)
        }
    }

    func loadSelectedCurrencies() -> [Currency]? {
        guard let data = userDefaults.data(forKey: currenciesKey) else { return nil }
        return try? JSONDecoder().decode([Currency].self, from: data)
    }

    func saveRatesCache(_ cache: CachedRates) {
        if let data = try? JSONEncoder().encode(cache) {
            userDefaults.set(data, forKey: ratesCacheKey)
        }
    }

    func loadRatesCache() -> CachedRates? {
        guard let data = userDefaults.data(forKey: ratesCacheKey) else { return nil }
        return try? JSONDecoder().decode(CachedRates.self, from: data)
    }
}
