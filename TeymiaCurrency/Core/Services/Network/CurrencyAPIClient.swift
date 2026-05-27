import Foundation

protocol CurrencyAPIClientProtocol: Sendable {
    func fetchFiatRates(base: String) async throws -> [String: Double]
    func fetchCryptoRates(ids: [String], vsCurrency: String) async throws -> [String: Double]
    func fetchTopCryptoList(vsCurrency: String, perPage: Int) async throws -> [CryptoMarketData]
}

final class CurrencyAPIClient: CurrencyAPIClientProtocol {
    private let session: URLSession
    private let fiatBaseURL = "https://api.exchangerate-api.com/v4"
    private let cryptoBaseURL = "https://api.coingecko.com/api/v3"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchFiatRates(base: String) async throws -> [String : Double] {
        let urlString = "\(fiatBaseURL)/latest/\(base)"
        let response: FiatExchangeResponse = try await performRequest(urlString: urlString)
        return response.rates
    }

    func fetchCryptoRates(ids: [String], vsCurrency: String) async throws -> [String: Double] {
        guard !ids.isEmpty else { return [:] }

        let idsString = ids.joined(separator: ",")
        let urlString = "\(cryptoBaseURL)/simple/price?ids=\(idsString)&vs_currencies=\(vsCurrency.lowercased())"

        let response: CryptoExchangeResponse = try await performRequest(urlString: urlString)

        var rates: [String: Double] = [:]
        for (coinId, priceData) in response {
            if let price = priceData[vsCurrency.lowercased()] {
                rates[coinId] = price
            }
        }
        return rates
    }

    func fetchTopCryptoList(vsCurrency: String, perPage: Int) async throws -> [CryptoMarketData] {
        let urlString = "\(cryptoBaseURL)/coins/markets?vs_currency=\(vsCurrency.lowercased())&order=market_cap_desc&per_page=\(perPage)&page=1&sparkline=false"
        return try await performRequest(urlString: urlString)
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
}

typealias CryptoExchangeResponse = [String: [String: Double]]
