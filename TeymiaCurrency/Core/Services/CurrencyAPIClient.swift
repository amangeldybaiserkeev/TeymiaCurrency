import Foundation

protocol CurrencyAPIClientProtocol {
    func fetchFiatRates(base: String) async throws -> [String: Double]
    func fetchCryptoRates(codes: [String], vsCurrency: String) async throws -> [String: Double]
}

final class CurrencyAPIClient: CurrencyAPIClientProtocol {
    private let session: URLSession
    private let fiatBaseURL = "https://api.exchangerate-api.com/v4"
    private let cryptoBaseURL = "https://api.coingecko.com/api/v3"

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Public

    func fetchFiatRates(base: String) async throws -> [String : Double] {
        let urlString = "\(fiatBaseURL)/latest/\(base)"
        let response: FiatExchangeResponse = try await performRequest(urlString: urlString)
        return response.rates
    }

    func fetchCryptoRates(codes: [String], vsCurrency: String) async throws -> [String: Double] {
        let coinIds = codes.compactMap { CryptoMapping.toCoinGeckoId($0) }
        guard !coinIds.isEmpty else { return [:] }

        let idsString = coinIds.joined(separator: ",")
        let urlString = "\(cryptoBaseURL)/simple/price?ids=\(idsString)&vs_currencies=\(vsCurrency)"

        let response: CryptoExchangeResponse = try await performRequest(urlString: urlString)

        var rates: [String: Double] = [:]
        for (coinId, priceData) in response {
            if let cryptoCode = CryptoMapping.toCryptoCode(coinId),
               let price = priceData[vsCurrency] {
                rates[cryptoCode] = price
            }
        }
        return rates
    }

    private func performRequest<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0

        let (data, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 200 else {
                throw NSError(
                    domain: "APIService",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP \(httpResponse.statusCode)"]
                )
            }
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    fileprivate struct CryptoMapping {
        private static let dictionary: [String: String] = [
            "AAVE": "aave", "ADA": "cardano", "ALGO": "algorand", "APT": "aptos",
            "ARB": "arbitrum", "ATOM": "cosmos", "AVAX": "avalanche-2", "AXS": "axie-infinity",
            "BCH": "bitcoin-cash", "BGB": "bitget-token", "BNB": "binancecoin", "BTC": "bitcoin",
            "BUSD": "binance-usd", "CFX": "conflux-token", "CRO": "crypto-com-chain", "DAI": "dai",
            "DOGE": "dogecoin", "DOT": "polkadot", "EGLD": "elrond-erd-2", "ETC": "ethereum-classic",
            "ETH": "ethereum", "FIL": "filecoin", "FLR": "flare-networks", "GRT": "the-graph",
            "HBAR": "hedera-hashgraph", "ICP": "internet-computer", "INJ": "injective-protocol",
            "JLP": "jupiter-exchange-solana", "KAS": "kaspa", "LDO": "lido-dao", "LEO": "leo-token",
            "LINK": "chainlink", "LTC": "litecoin", "LUNC": "terra-luna-classic", "METH": "mantle-staked-ether",
            "NEAR": "near", "OP": "optimism", "POL": "matic-network", "PYTH": "pyth-network",
            "QNT": "quant-network", "RENDER": "render-token", "SEI": "sei-network", "SHIB": "shiba-inu",
            "SOL": "solana", "STETH": "staked-ether", "STX": "blockstack", "SUI": "sui",
            "TAO": "bittensor", "THETA": "theta-token", "TIA": "celestia", "TON": "the-open-network",
            "TRX": "tron", "UNI": "uniswap", "USDC": "usd-coin", "USDT": "tether", "VET": "vechain",
            "WBT": "whitebit", "WBTC": "wrapped-bitcoin", "XLM": "stellar", "XMR": "monero",
            "XRP": "ripple", "XTZ": "tezos", "ZEC": "zcash"
        ]

        private static let reversedDictionary: [String: String] = Dictionary(uniqueKeysWithValues: dictionary.map { ($1, $0) })

        static func toCoinGeckoId(_ code: String) -> String? {
            dictionary[code.uppercased()]
        }

        static func toCryptoCode(_ id: String) -> String? {
            reversedDictionary[id.lowercased()]
        }
    }
}

typealias CryptoExchangeResponse = [String: [String: Double]]
