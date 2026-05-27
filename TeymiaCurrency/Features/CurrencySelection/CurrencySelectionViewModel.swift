import Foundation

@Observable
@MainActor
final class CurrencySelectionViewModel {
    private let repository: CurrencyRepositoryProtocol
    private(set) var allCurrencies: [Currency] = []
    private(set) var selectedCurrencies: [Currency] = []
    private var observeTask: Task<Void, Never>?

    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
        startObserving()
        loadAllCurrencies()
    }

    private func loadAllCurrencies() {
        Task {
            do {
                self.allCurrencies = try await repository.fetchAllCurrencies()
            } catch {
                print("❌ Ошибка загрузки валют: \(error.localizedDescription)")

                // Фолбэк: если сеть лежит, пытаемся достать хотя бы локальный фиат
                if let localFiatProvider = (repository as? CurrencyRepository) {
                    // Если архитектура позволяет, можно загрузить только фиат,
                    // либо вернуть пустой массив, но не ломать UI
                }

                // Для безопасности: если упало всё вместе, давай попробуем показать хотя бы пустой массив,
                // но в идеале — подгрузить фиат напрямую, если упала только крипта.
            }
        }
    }

    func buildSections(searchText: String, selectedType: CurrencyType) -> [CurrencySection] {
        let base = searchText.isEmpty ? allCurrencies.filter { $0.type == selectedType } : allCurrencies

        if searchText.isEmpty {
            return groupAndSort(base)
        }

        let query = searchText.lowercased()
        let filtered = base.filter {
            $0.code.lowercased().contains(query) ||
            $0.name.lowercased().contains(query)
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
            guard selectedCurrencies.count > 1 else { return }
            selectedCurrencies.removeAll { $0.code == currency.code }
        } else {
            selectedCurrencies.append(currency)
        }

        Task {
            await repository.saveSelectedCurrencies(selectedCurrencies)
        }
    }

    private func startObserving() {
            observeTask = Task { [weak self] in
                guard let self else { return }
                for await currencies in self.repository.observeSelectedCurrencies() {
                    self.selectedCurrencies = currencies
                }
            }
        }
}
