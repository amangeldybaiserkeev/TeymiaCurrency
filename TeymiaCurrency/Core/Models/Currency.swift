import SwiftUI

struct Currency: Codable, Identifiable, Hashable, Sendable {
    var id: String { code }
    let code: String
    let name: LocalizedStringResource
    let type: CurrencyType
    let symbol: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code == rhs.code
    }
}

struct CachedRates: Codable, Sendable {
    let timestamp: Date
    let rates: [String: Double]
}

enum CurrencyType: String, Codable, Sendable {
    case fiat
    case crypto
}
