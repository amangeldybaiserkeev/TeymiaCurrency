import Foundation

protocol CurrencyStaticDataProviderProtocol: Sendable {
    func loadInitialCurrencies() async throws -> [Currency]
}

final class LocalJSONCurrencyProvider: CurrencyStaticDataProviderProtocol {
    private let bundle: Bundle
    private let fileName: String

    init(bundle: Bundle = .main, fileName: String = "fiat_currencies") {
        self.bundle = bundle
        self.fileName = fileName
    }

    func loadInitialCurrencies() async throws -> [Currency] {
        try await Task.detached(priority: .userInitiated) { [bundle, fileName] in
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
                throw CocoaError(.fileReadNoSuchFile)
            }
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Currency].self, from: data)
        }.value
    }
}
