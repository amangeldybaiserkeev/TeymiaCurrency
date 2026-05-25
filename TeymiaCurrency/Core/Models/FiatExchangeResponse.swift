import Foundation

struct FiatExchangeResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}
