import SwiftUI

struct CurrencyRowView: View {
    let currency: Currency
    @Bindable var vm: ConverterViewModel
    @State private var fieldVM: CurrencyFieldViewModel
    @FocusState.Binding var focusedCurrency: String?

    init(
        currency: Currency,
        vm: ConverterViewModel,
        focusedCurrency: FocusState<String?>.Binding
    ) {
        self.currency = currency
        self.vm = vm
        self._focusedCurrency = focusedCurrency

        let initialVM = CurrencyFieldViewModel(
            currency: currency,
            onAmountChange: { amount, code in
                vm.updateAmount(amount, for: code)
            }
        )
        _fieldVM = State(initialValue: initialVM)
    }

    var body: some View {
        HStack {
            CurrencyBadge(currency: currency)

            Spacer()

            CustomTextFieldWithKeyboard(text: $fieldVM.inputText, placeholder: "0") {
                customKeyboard
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .focused($focusedCurrency, equals: currency.code)
        }
        .padding(.vertical, Spacing.xxs)
        .contentShape(.rect)
        .onTapGesture {
            focusedCurrency = currency.code
        }
        .onChange(of: focusedCurrency) { _, newFocusedCode in
            handleFocusChange(newFocusedCode)
        }
        .onChange(of: vm.baseAmount) { _, _ in
            updateDisplayIfNeeded()
        }
        .onChange(of: vm.exchangeRates) { _, _ in
            updateDisplayIfNeeded()
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
            fieldVM.startEditing(with: vm.getDisplayAmount(for: currency.code))
        } else if fieldVM.isEditing {
            fieldVM.commitEditing()
        }
    }

    private func updateDisplayIfNeeded() {
        guard !fieldVM.isEditing else { return }
        updateDisplay()
    }

    private func updateDisplay() {
        let amount = vm.getDisplayAmount(for: currency.code)
        fieldVM.updateDisplay(with: amount)
    }
}
