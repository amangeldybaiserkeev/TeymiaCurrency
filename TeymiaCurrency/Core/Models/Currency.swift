import Foundation

struct Currency: Codable, Identifiable, Hashable, Sendable {
    var id: String { code }
    let code: String
    let name: String
    let type: CurrencyType
    let iconUrlString: String?
    let coinGeckoId: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code == rhs.code
    }
}

extension Currency {
//    var dynamicLocalizedName: String {
//        String(localized: name)
//    }

    var iconURL: URL? {
        if self.type == .fiat {
            let countryCode = String(code.prefix(2).lowercased())
            return URL(string: "https://flagfeed.com/country/\(countryCode)")
        } else {
            if let iconUrlString, let url = URL(string: iconUrlString) {
                return url
            }
            return URL(string: "https://assets.coingecko.com/coins/images/1/large/\(code.lowercased()).png")
        }
    }
}
