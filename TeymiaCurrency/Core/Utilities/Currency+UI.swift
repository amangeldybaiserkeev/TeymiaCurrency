import Foundation

extension Currency {

    var dynamicLocalizedName: String {
        String(localized: name)
    }

    var iconName: String {
        if self.type == .fiat {
            return self.code
        } else {
            return getCryptoIconName(for: self.code)
        }
    }

    private func getCryptoIconName(for cryptoCode: String) -> String {
        let availableCryptoIcons: Set<String> = [
            "AAVE", "ADA", "ALGO", "APT", "ARB", "ATOM", "AVAX", "AXS", "BCH",
            "BGB", "BNB", "BTC", "BUSD", "CFX", "CRO", "DAI", "DOGE", "DOT",
            "EGLD", "ETC", "ETH", "FIL", "FLR", "GRT", "HBAR", "ICP", "INJ",
            "JLP", "KAS", "LDO", "LEO", "LINK", "LTC", "LUNC", "METH", "NEAR",
            "OP", "POL", "PYTH", "QNT", "RENDER", "SEI", "SHIB", "SOL", "STETH",
            "STX", "SUI", "TAO", "THETA", "TIA", "TON", "TRX", "UNI", "USDC",
            "USDT", "VET", "WBT", "WBTC", "XLM", "XMR", "XRP", "XTZ", "ZEC"
        ]

        return availableCryptoIcons.contains(cryptoCode) ? cryptoCode : "BTC"
    }
}
