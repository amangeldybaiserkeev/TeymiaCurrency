import Foundation

struct ExchangeRates: Equatable {
    let baseCurrency: String
    let rates: [String: Double]
    let timestamp: Date
}
