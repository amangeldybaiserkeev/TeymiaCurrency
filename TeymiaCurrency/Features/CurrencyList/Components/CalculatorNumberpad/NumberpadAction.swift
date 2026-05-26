import SwiftUI

enum NumberpadAction: Hashable, Comparable {

    case clear, dismiss, divide
    case seven, eight, nine, subtract
    case four, five, six, multiply
    case one, two, three, add
    case decimal, zero, delete, equals

    var displayValue: String {
        switch self {
        case .clear: "C"; case .dismiss: "⌄"; case .divide: "÷"
        case .seven: "7"; case .eight: "8"; case .nine: "9"; case .subtract: "-"
        case .four: "4"; case .five: "5"; case .six: "6"; case .multiply: "×"
        case .one: "1"; case .two: "2"; case .three: "3" case .add: "+"
        case .decimal: ","; case .zero: "0"; case .delete: "⌫"; case .equals: "="
        }
    }

    var systemImage: String? {
        switch self {
        case .divide: "divide"
        case .multiply: "multiply"
        case .subtract: "minus"
        case .add: "plus"
        case .equals: "equal"
        case .delete: "delete.left"
        case .dismiss: "keyboard.chevron.compact.down"
        default: nil
        }
    }

    var backgroundColor: Color {
        switch self {
        case .clear, .dismiss, .decimal, .delete:
                .numberpadSecondary
        case .add, .subtract, .multiply, .divide, .equals:
                .numberpadAccent
        default:
                .numberpadPrimary
        }
    }

    var foregroundColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equals:
            .onPrimary
        default:
            .primary
        }
    }
}
