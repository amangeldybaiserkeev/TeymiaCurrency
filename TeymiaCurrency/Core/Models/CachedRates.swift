import Foundation

struct CachedRates: Codable, Sendable {
    let timestamp: Date
    let rates: [String: Double]
}
