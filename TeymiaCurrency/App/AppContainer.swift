import Foundation

@Observable
final class AppContainer {
    private let formattingService: NumberFormattingServiceProtocol
    private let calculatorEngine: CalculatorEngineProtocol
    private let repository: CurrencyRepositoryProtocol

    init() {
        self.formattingService = NumberFormattingService()
        self.calculatorEngine = CalculatorEngine()

        let storage = CurrencyUserDefaultsStorage()
        let apiClient = CurrencyAPIClient()
        self.repository = CurrencyRepository(apiClient: apiClient, storage: storage)
    }

    @MainActor
    func makeConverterViewModel() -> ConverterViewModel {
        ConverterViewModel(repository: repository)
    }

    @MainActor
    func makeCurrencyFieldViewModel(
            currency: Currency,
            onAmountChange: @escaping (Double, String) -> Void
        ) -> CurrencyFieldViewModel {
            CurrencyFieldViewModel(
                currency: currency,
                formatter: formattingService,
                calculator: calculatorEngine,
                onAmountChange: onAmountChange
            )
        }
}
