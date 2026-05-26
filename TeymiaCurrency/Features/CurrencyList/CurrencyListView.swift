import SwiftUI

struct CurrencyListView: View {
    @State private var showingCurrencySelection = false
    @State private var showingSettings = false
    @FocusState private var focusedCurrency: String?
    @Namespace private var namespace
    @Environment(DIContainer.self) private var container

    let vm: CurrencyListViewModel

    var body: some View {
        List {
            ForEach(vm.selectedCurrencies, id: \.code) { currency in
                let rowFieldVM = container.makeCurrencyFieldViewModel(currency: currency) { amount, code in
                    vm.updateAmount(amount, for: code)
                }

                CurrencyRowView(
                    currency: currency,
                    listVM: vm,
                    fieldVM: rowFieldVM,
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
        .navigationTitle("Converter")
        .toolbar { toolbarContent }
        .onAppear { vm.fetchRates() }
        .sheet(isPresented: $showingCurrencySelection) {
            let selectionVM = CurrencySelectionViewModel(repository: vm.repository)

            CurrencySelectionView(vm: selectionVM)
                .appNavigationZoomTransition(id: AnimationIDs.plusZoom, in: namespace)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
                .appNavigationZoomTransition(id: AnimationIDs.settingsZoom, in: namespace)
        }
        .appSensoryFeedback(.selection, trigger: showingSettings || showingCurrencySelection)
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        SettingsToolbarButton(namespace: namespace) {
            showingSettings = true
        }
        PlusToolbarButton(namespace: namespace) {
            showingCurrencySelection = true
        }
    }


    private func moveCurrencies(from source: IndexSet, to destination: Int) {
        vm.moveCurrency(from: source, to: destination)
    }
}
