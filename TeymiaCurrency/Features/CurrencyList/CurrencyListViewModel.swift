import SwiftUI

@Observable
@MainActor
final class CurrencyListViewModel {
    private(set) var selectedCurrencies: [Currency] = []
    private(set) var exchangeRates: [String: Double] = [:]
    private(set) var isLoading = false

    var baseAmount: Double = 1.0
    var editingCurrency: String = "USD"

    let repository: CurrencyRepositoryProtocol
    private var observeTask: Task<Void, Never>?

    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
        startObserving()
    }

    func fetchRates() {
        guard !selectedCurrencies.isEmpty else { return }
        isLoading = true
        Task {
            do {
                self.exchangeRates = try await repository.getLatestRates(for: selectedCurrencies, baseCurrency: "USD")
                self.isLoading = false
            } catch {
                self.isLoading = false
            }
        }
    }

    func getDisplayAmount(for currencyCode: String) -> Double {
        guard !exchangeRates.isEmpty else { return baseAmount }

        let sourceRate = exchangeRates[editingCurrency] ?? 1.0
        let targetRate = exchangeRates[currencyCode] ?? 1.0

        let sourceCurrency = selectedCurrencies.first { $0.code == editingCurrency }
        let targetCurrency = selectedCurrencies.first { $0.code == currencyCode }

        let amountInUSD: Double
        if sourceCurrency?.type == .crypto {
            amountInUSD = baseAmount * sourceRate
        } else {
            amountInUSD = baseAmount / sourceRate
        }

        if targetCurrency?.type == .crypto {
            return amountInUSD / targetRate
        } else {
            return amountInUSD * targetRate
        }
    }

    func updateAmount(_ amount: Double, for currencyCode: String) {
        self.editingCurrency = currencyCode
        self.baseAmount = amount
    }

    func removeCurrency(_ currency: Currency) {
        guard selectedCurrencies.count > 1 else { return }
        selectedCurrencies.removeAll { $0.code == currency.code }
        Task {
            await repository.saveSelectedCurrencies(selectedCurrencies)
        }
    }

    func moveCurrency(from source: IndexSet, to destination: Int) {
        selectedCurrencies.move(fromOffsets: source, toOffset: destination)
        Task {
            await repository.saveSelectedCurrencies(selectedCurrencies)
        }
    }

    private func startObserving() {
        observeTask = Task { [weak self] in
            guard let self else { return }
            for await currencies in self.repository.observeSelectedCurrencies() {
                self.selectedCurrencies = currencies
                self.fetchRates()
            }
        }
    }
}
