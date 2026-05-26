import SwiftUI

struct CurrencyRowView: View {
    let currency: Currency
    @Bindable var listVM: CurrencyListViewModel
    var fieldVM: CurrencyFieldViewModel
    @FocusState.Binding var focusedCurrency: String?

    init(
        currency: Currency,
        listVM: CurrencyListViewModel,
        fieldVM: CurrencyFieldViewModel,
        focusedCurrency: FocusState<String?>.Binding
    ) {
        self.currency = currency
        self.listVM = listVM
        self.fieldVM = fieldVM
        self._focusedCurrency = focusedCurrency
    }

    var body: some View {
        @Bindable var bindableFieldVM = fieldVM

        HStack {
            CurrencyBadge(currency: currency)
                .layoutPriority(1)

            CustomTextFieldWithKeyboard(text: $bindableFieldVM.inputText, placeholder: "0") {
                customKeyboard
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .focused($focusedCurrency, equals: currency.code)
        }
        .contentShape(.rect)
        .onTapGesture {
            focusedCurrency = currency.code
        }
        .onChange(of: focusedCurrency) { _, newFocusedCode in
            handleFocusChange(newFocusedCode)
        }
        .onChange(of: listVM.baseAmount) { _, _ in
            updateDisplayIfNeeded()
        }
        .onChange(of: listVM.exchangeRates) { _, _ in
            updateDisplayIfNeeded()
        }
        .onAppear {
            updateDisplay()
        }
    }

    @ViewBuilder
    private var customKeyboard: some View {
        CalculatorNumberpadView { action in
            if action == .dismiss {
                focusedCurrency = nil
            } else {
                fieldVM.handleCalculatorAction(action)
            }
        }
    }

    private func handleFocusChange(_ newFocusedCode: String?) {
        if newFocusedCode == currency.code {
            fieldVM.startEditing(with: listVM.getDisplayAmount(for: currency.code))
        } else if fieldVM.isEditing {
            fieldVM.commitEditing()
        }
    }

    private func updateDisplayIfNeeded() {
        guard !fieldVM.isEditing else { return }
        updateDisplay()
    }

    private func updateDisplay() {
        let amount = listVM.getDisplayAmount(for: currency.code)
        fieldVM.updateDisplay(with: amount)
    }
}
