import SwiftUI

@Observable
@MainActor
final class ConverterViewModel {

    private(set) var selectedCurrencies: [Currency] = []
    private(set) var exchangeRates: [String: Double] = [:]
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    var baseAmount: Double = 1.0
    var editingCurrency: String = "USD"

    private let repository: CurrencyRepositoryProtocol

    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
        setupInitialData()
    }

    func fetchRates() {
        guard !selectedCurrencies.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let rates = try await repository.getLatestRates(
                    for: selectedCurrencies,
                    baseCurrency: "USD"
                )
                self.exchangeRates = rates
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }

    // MARK: - Currency Selection
    func buildSections(searchText: String, selectedType: CurrencyType) -> [CurrencySection] {
        let all = (CurrencyData.fiatCurrencies + CurrencyData.cryptoCurrencies)
        let base = searchText.isEmpty ? all.filter { $0.type == selectedType } : all

        if searchText.isEmpty {
            return groupAndSort(base)
        }

        let query = searchText.lowercased()
        let filtered = base.filter {
            $0.code.lowercased().contains(query) ||
            $0.dynamicLocalizedName.lowercased().contains(query)
        }.sorted {
            let lExact = $0.code.lowercased() == query
            let rExact = $1.code.lowercased() == query
            if lExact && !rExact { return true }
            if !lExact && rExact { return false }
            return $0.code < $1.code
        }

        return groupAndSort(filtered)
    }

    private func groupAndSort(_ currencies: [Currency]) -> [CurrencySection] {
        let sorted = currencies.sorted { $0.code < $1.code }
        let grouped = Dictionary(grouping: sorted) { String($0.code.prefix(1)).uppercased() }
        return grouped.keys.sorted().map { letter in
            CurrencySection(id: letter, letter: letter, currencies: grouped[letter] ?? [])
        }
    }

    func toggleCurrency(_ currency: Currency) {
        if selectedCurrencies.contains(where: { $0.code == currency.code }) {
            removeCurrency(currency)
        } else {
            addCurrency(currency)
        }
    }

    // MARK: - CRUD
    func addCurrency(_ currency: Currency) {
        guard !selectedCurrencies.contains(where: { $0.code == currency.code }) else { return }
        selectedCurrencies.append(currency)
        repository.saveSelectedCurrencies(selectedCurrencies)
        fetchRates()
    }

    func removeCurrency(_ currency: Currency) {
        guard selectedCurrencies.count > 1 else { return }
        selectedCurrencies.removeAll { $0.code == currency.code }
        repository.saveSelectedCurrencies(selectedCurrencies)
    }

    func moveCurrency(from source: IndexSet, to destination: Int) {
        selectedCurrencies.move(fromOffsets: source, toOffset: destination)
        repository.saveSelectedCurrencies(selectedCurrencies)
    }

    func getDisplayAmount(for currencyCode: String) -> Double {
        if currencyCode == "USD" { return baseAmount }
        let rate = exchangeRates[currencyCode] ?? 1.0

        let currency = selectedCurrencies.first { $0.code == currencyCode }
        if currency?.type == .crypto {
            return baseAmount / rate
        } else {
            return baseAmount * rate
        }
    }

    func updateAmount(_ amount: Double, for currencyCode: String) {
        editingCurrency = currencyCode
        if currencyCode == "USD" {
            baseAmount = amount
        } else {
            let rate = exchangeRates[currencyCode] ?? 1.0
            let currency = selectedCurrencies.first { $0.code == currencyCode }
            if currency?.type == .crypto {
                baseAmount = amount * rate
            } else {
                baseAmount = amount / rate
            }
        }
    }

    private func setupInitialData() {
        self.selectedCurrencies = repository.loadSelectedCurrencies()
        fetchRates()
    }
}
