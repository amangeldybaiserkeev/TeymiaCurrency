import SwiftUI

struct MainView: View {
    @State private var showingCurrencySelection = false
    @State private var showingSettings = false
    @FocusState private var focusedCurrency: String?

    let vm: ConverterViewModel

    var body: some View {
        List {
            ForEach(vm.selectedCurrencies, id: \.code) { currency in
                CurrencyRowView(
                    currency: currency,
                    vm: vm,
                    focusedCurrency: $focusedCurrency
                )
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        vm.removeCurrency(currency)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
            .onMove(perform: moveCurrencies)
        }
        .listStyle(.plain)
        .toolbar { toolbarContent }
        .onAppear { vm.fetchRates() }
        .sheet(isPresented: $showingCurrencySelection) {
            NavigationStack {
                CurrencySelectionView(vm: vm)
            }
        }
        .sheet(isPresented: $showingSettings) {
            NavigationStack {
                SettingsView()
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        SettingsToolbarButton { showingSettings = true }
        PlusToolbarButton { showingCurrencySelection = true }
    }


    private func moveCurrencies(from source: IndexSet, to destination: Int) {
        vm.moveCurrency(from: source, to: destination)
    }
}
