import Foundation

protocol NumberFormattingServiceProtocol {
    func formatAmount(_ amount: Double, currencyType: CurrencyType) -> String
    func parseInput(_ input: String) -> Double?
    func validateInput(_ input: String, currencyType: CurrencyType) -> String
}

final class NumberFormattingService: NumberFormattingServiceProtocol {
    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = " "
        f.decimalSeparator = ","
        return f
    }()

    func formatAmount(_ amount: Double, currencyType: CurrencyType) -> String {
        formatter.maximumFractionDigits = fractionDigits(for: amount, currencyType: currencyType)
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }

    func parseInput(_ input: String) -> Double? {
        let cleaned = input
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: ".")
        return Double(cleaned)
    }

    func validateInput(_ input: String, currencyType: CurrencyType) -> String {
        var result = input.filter { "0123456789, ".contains($0) }

        if currencyType == .fiat {
            let parts = result.split(separator: ",")
            if parts.count == 2 && parts[1].count > 2 {
                result = String(parts[0] + "," + String(parts[1].prefix(2)))
            }
        }
        return result
    }

    private func fractionDigits(for amount: Double, currencyType: CurrencyType) -> Int {
        switch currencyType {
        case .crypto:
            switch amount {
            case 1000...: return 0
            case 1...: return 2
            case 0.01...: return 4
            default : return 8
            }
        case .fiat:
            switch amount {
            case 1_000_000...: return 0
            case 1000...: return 2
            case 1...: return 2
            case 0.01...: return 4
            default: return 8
            }
        }
    }
}
