import Foundation

protocol CalculatorEngineProtocol {
    func performOperation(_ operation: MathOperation, value: Double) -> Double
    func reset()
}

final class CalculatorEngine: CalculatorEngineProtocol {
    private var state = CalculatorState()

    func performOperation(_ operation: MathOperation, value: Double) -> Double {
        switch operation {
        case .add, .subtract, .multiply, .divide, .equals:
            return performBinaryOperation(operation, value: value)
        }
    }

    private func performBinaryOperation(_ operation: MathOperation, value: Double) -> Double {

        guard let pendingOp = state.pendingOperation else {
            state.previousValue = value
            state.pendingOperation = operation
            return value
        }

        let result: Double
        switch pendingOp {
        case .add:
            result = state.previousValue + value
        case .subtract:
            result = state.previousValue - value
        case .multiply:
            result = state.previousValue * value
        case .divide:
            result = value != 0 ? state.previousValue / value : state.previousValue
        default:
            result = value
        }

        state.previousValue = result
        state.pendingOperation = operation == .equals ? nil : operation

        return result
    }

    func reset() {
        state = CalculatorState()
    }
}

enum MathOperation {
    case add, subtract, multiply, divide, equals
}

struct CalculatorState {
    var currentValue: Double = 0
    var previousValue: Double = 0
    var pendingOperation: MathOperation?
}
