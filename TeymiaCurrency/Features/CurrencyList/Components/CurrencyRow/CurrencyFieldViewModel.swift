import Foundation

@Observable
@MainActor
final class CurrencyFieldViewModel {
    var inputText: String = ""
    var isEditing: Bool = false

    private let currency: Currency
    private let formatter: NumberFormattingServiceProtocol
    private let calculator: CalculatorEngineProtocol
    private let onAmountChange: (Double, String) -> Void
    private var lastValidValue: Double = 0

    init(
        currency: Currency,
        formatter: NumberFormattingServiceProtocol = NumberFormattingService(),
        calculator: CalculatorEngineProtocol = CalculatorEngine(),
        onAmountChange: @escaping (Double, String) -> Void
    ) {
        self.currency = currency
        self.formatter = formatter
        self.calculator = calculator
        self.onAmountChange = onAmountChange
    }

    // MARK: - Public

    func startEditing(with amount: Double) {
        isEditing = true
        lastValidValue = amount
        inputText = formatter.formatAmount(amount, currencyType: currency.type)
    }

    func commitEditing() {
        isEditing = false
        let finalValue = formatter.parseInput(inputText) ?? lastValidValue
        inputText = formatter.formatAmount(finalValue, currencyType: currency.type)
        onAmountChange(finalValue, currency.code)
    }

    func updateDisplay(with amount: Double) {
        guard !isEditing else { return }
        inputText = formatter.formatAmount(amount, currencyType: currency.type)
    }

    func handleCalculatorAction(_ action: NumberpadAction) {
        guard isEditing else { return }

        let currentValue = formatter.parseInput(inputText) ?? 0

        switch action {
        case .add, .subtract, .multiply, .divide:
            let mathOp = mapToMathOperation(action)
            let result = calculator.performOperation(mathOp, value: currentValue)
            inputText = formatter.formatAmount(result, currencyType: currency.type)

            if mathOp == .equals {
                onAmountChange(result, currency.code)
                calculator.reset()
            }

        case .equals:
            let result = calculator.performOperation(.equals, value: currentValue)
            inputText = formatter.formatAmount(result, currencyType: currency.type)
            onAmountChange(result, currency.code)
            calculator.reset()

        case .clear:
            calculator.reset()
            inputText = ""
            onAmountChange(0, currency.code)

        case .delete:
            let newInput = String(inputText.dropLast())
            if let newValue = formatter.parseInput(newInput) {
                inputText = newInput
                onAmountChange(newValue, currency.code)
            } else if newInput.isEmpty {
                inputText = ""
                onAmountChange(0, currency.code)
            }

        default:
            handleDigitInput(action)
        }
    }

    // MARK: - Private

    private func handleDigitInput(_ action: NumberpadAction) {
        var newInput = inputText

        switch action {
        case .decimal:
            if !newInput.contains(",") {
                newInput = newInput.isEmpty ? "0," : newInput + ","
            }

        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            let digit = action.displayValue
            if newInput == "0" && digit != "0" {
                newInput = digit
            } else {
                newInput += digit
            }

        default:
            break
        }

        let validated = formatter.validateInput(newInput, currencyType: currency.type)

        if let newValue = formatter.parseInput(validated) {
            inputText = validated
            onAmountChange(newValue, currency.code)
        } else {
            inputText = validated
        }
    }

    private func mapToMathOperation(_ action: NumberpadAction) -> MathOperation {
        switch action {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        default: return .equals
        }
    }
}
