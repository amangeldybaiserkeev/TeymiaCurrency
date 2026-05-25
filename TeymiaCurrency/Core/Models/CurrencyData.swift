import Foundation

struct CurrencyData {
    static let fiatCurrencies: [Currency] = [
        // TIER 1: Major global currencies (most traded by volume 2024-2025)
        Currency(code: "USD", name: "currency_us_dollar", type: .fiat, symbol: "$"),
        Currency(code: "EUR", name: "currency_euro", type: .fiat, symbol: "€"),
        Currency(code: "JPY", name: "currency_japanese_yen", type: .fiat, symbol: "¥"),
        Currency(code: "GBP", name: "currency_british_pound", type: .fiat, symbol: "£"),
        Currency(code: "CNY", name: "currency_chinese_yuan", type: .fiat, symbol: "¥"),
        Currency(code: "AUD", name: "currency_australian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "CAD", name: "currency_canadian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "CHF", name: "currency_swiss_franc", type: .fiat, symbol: "CHF"),
        Currency(code: "HKD", name: "currency_hong_kong_dollar", type: .fiat, symbol: "$"),
        Currency(code: "SGD", name: "currency_singapore_dollar", type: .fiat, symbol: "$"),

        // TIER 2: Regional powerhouses & popular trading pairs
        Currency(code: "NZD", name: "currency_new_zealand_dollar", type: .fiat, symbol: "$"),
        Currency(code: "SEK", name: "currency_swedish_krona", type: .fiat, symbol: "kr"),
        Currency(code: "NOK", name: "currency_norwegian_krone", type: .fiat, symbol: "kr"),
        Currency(code: "DKK", name: "currency_danish_krone", type: .fiat, symbol: "kr"),
        Currency(code: "KRW", name: "currency_south_korean_won", type: .fiat, symbol: "₩"),
        Currency(code: "INR", name: "currency_indian_rupee", type: .fiat, symbol: "₹"),
        Currency(code: "BRL", name: "currency_brazilian_real", type: .fiat, symbol: "R$"),
        Currency(code: "MXN", name: "currency_mexican_peso", type: .fiat, symbol: "$"),
        Currency(code: "RUB", name: "currency_russian_ruble", type: .fiat, symbol: "₽"),

        // TIER 3: Rest alphabetically (regional/emerging markets)
        Currency(code: "AED", name: "currency_uae_dirham", type: .fiat, symbol: "د.إ"),
        Currency(code: "AFN", name: "currency_afghan_afghani", type: .fiat, symbol: "؋"),
        Currency(code: "ALL", name: "currency_albanian_lek", type: .fiat, symbol: "L"),
        Currency(code: "AMD", name: "currency_armenian_dram", type: .fiat, symbol: "֏"),
        Currency(code: "ANG", name: "currency_netherlands_antillean_guilder", type: .fiat, symbol: "ƒ"),
        Currency(code: "AOA", name: "currency_angolan_kwanza", type: .fiat, symbol: "Kz"),
        Currency(code: "ARS", name: "currency_argentine_peso", type: .fiat, symbol: "$"),
        Currency(code: "AWG", name: "currency_aruban_florin", type: .fiat, symbol: "ƒ"),
        Currency(code: "AZN", name: "currency_azerbaijani_manat", type: .fiat, symbol: "₼"),
        Currency(code: "BAM", name: "currency_bosnia_herzegovina_convertible_mark", type: .fiat, symbol: "KM"),
        Currency(code: "BBD", name: "currency_barbadian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "BDT", name: "currency_bangladeshi_taka", type: .fiat, symbol: "৳"),
        Currency(code: "BGN", name: "currency_bulgarian_lev", type: .fiat, symbol: "лв"),
        Currency(code: "BHD", name: "currency_bahraini_dinar", type: .fiat, symbol: ".د.ب"),
        Currency(code: "BIF", name: "currency_burundian_franc", type: .fiat, symbol: "FBu"),
        Currency(code: "BMD", name: "currency_bermudian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "BND", name: "currency_brunei_dollar", type: .fiat, symbol: "$"),
        Currency(code: "BOB", name: "currency_bolivian_boliviano", type: .fiat, symbol: "b$"),
        Currency(code: "BSD", name: "currency_bahamian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "BTN", name: "currency_bhutanese_ngultrum", type: .fiat, symbol: "Nu."),
        Currency(code: "BWP", name: "currency_botswanan_pula", type: .fiat, symbol: "P"),
        Currency(code: "BYN", name: "currency_belarusian_ruble", type: .fiat, symbol: "Br"),
        Currency(code: "BZD", name: "currency_belize_dollar", type: .fiat, symbol: "BZ$"),
        Currency(code: "CDF", name: "currency_congolese_franc", type: .fiat, symbol: "FC"),
        Currency(code: "CLP", name: "currency_chilean_peso", type: .fiat, symbol: "$"),
        Currency(code: "COP", name: "currency_colombian_peso", type: .fiat, symbol: "$"),
        Currency(code: "CRC", name: "currency_costa_rican_colon", type: .fiat, symbol: "₡"),
        Currency(code: "CUC", name: "currency_cuban_convertible_peso", type: .fiat, symbol: "CUC$"),
        Currency(code: "CUP", name: "currency_cuban_peso", type: .fiat, symbol: "₱"),
        Currency(code: "CVE", name: "currency_cape_verdean_escudo", type: .fiat, symbol: "$"),
        Currency(code: "CZK", name: "currency_czech_koruna", type: .fiat, symbol: "Kč"),
        Currency(code: "DJF", name: "currency_djiboutian_franc", type: .fiat, symbol: "Fdj"),
        Currency(code: "DOP", name: "currency_dominican_peso", type: .fiat, symbol: "RD$"),
        Currency(code: "DZD", name: "currency_algerian_dinar", type: .fiat, symbol: "د.ج"),
        Currency(code: "EGP", name: "currency_egyptian_pound", type: .fiat, symbol: "E£"),
        Currency(code: "ERN", name: "currency_eritrean_nakfa", type: .fiat, symbol: "Nfk"),
        Currency(code: "ETB", name: "currency_ethiopian_birr", type: .fiat, symbol: "Br"),
        Currency(code: "FJD", name: "currency_fijian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "FKP", name: "currency_falkland_islands_pound", type: .fiat, symbol: "£"),
        Currency(code: "FOK", name: "currency_faroese_krona", type: .fiat, symbol: "kr"),
        Currency(code: "GEL", name: "currency_georgian_lari", type: .fiat, symbol: "₾"),
        Currency(code: "GGP", name: "currency_guernsey_pound", type: .fiat, symbol: "£"),
        Currency(code: "GHS", name: "currency_ghanaian_cedi", type: .fiat, symbol: "₵"),
        Currency(code: "GIP", name: "currency_gibraltar_pound", type: .fiat, symbol: "£"),
        Currency(code: "GMD", name: "currency_gambian_dalasi", type: .fiat, symbol: "D"),
        Currency(code: "GNF", name: "currency_guinean_franc", type: .fiat, symbol: "FG"),
        Currency(code: "GTQ", name: "currency_guatemalan_quetzal", type: .fiat, symbol: "Q"),
        Currency(code: "GYD", name: "currency_guyanaese_dollar", type: .fiat, symbol: "$"),
        Currency(code: "HNL", name: "currency_honduran_lempira", type: .fiat, symbol: "L"),
        Currency(code: "HRK", name: "currency_croatian_kuna", type: .fiat, symbol: "kn"),
        Currency(code: "HTG", name: "currency_haitian_gourde", type: .fiat, symbol: "G"),
        Currency(code: "HUF", name: "currency_hungarian_forint", type: .fiat, symbol: "Ft"),
        Currency(code: "IDR", name: "currency_indonesian_rupiah", type: .fiat, symbol: "Rp"),
        Currency(code: "ILS", name: "currency_israeli_shekel", type: .fiat, symbol: "₪"),
        Currency(code: "IMP", name: "currency_manx_pound", type: .fiat, symbol: "£"),
        Currency(code: "IQD", name: "currency_iraqi_dinar", type: .fiat, symbol: "ع.د"),
        Currency(code: "IRR", name: "currency_iranian_rial", type: .fiat, symbol: "﷼"),
        Currency(code: "ISK", name: "currency_icelandic_krona", type: .fiat, symbol: "kr"),
        Currency(code: "JEP", name: "currency_jersey_pound", type: .fiat, symbol: "£"),
        Currency(code: "JMD", name: "currency_jamaican_dollar", type: .fiat, symbol: "J$"),
        Currency(code: "JOD", name: "currency_jordanian_dinar", type: .fiat, symbol: "د.ا"),
        Currency(code: "KES", name: "currency_kenyan_shilling", type: .fiat, symbol: "KSh"),
        Currency(code: "KGS", name: "currency_kyrgyzstani_som", type: .fiat, symbol: "сом"),
        Currency(code: "KHR", name: "currency_cambodian_riel", type: .fiat, symbol: "៛"),
        Currency(code: "KID", name: "currency_kiribati_dollar", type: .fiat, symbol: "$"),
        Currency(code: "KMF", name: "currency_comorian_franc", type: .fiat, symbol: "CF"),
        Currency(code: "KPW", name: "currency_north_korean_won", type: .fiat, symbol: "₩"),
        Currency(code: "KWD", name: "currency_kuwaiti_dinar", type: .fiat, symbol: "د.ك"),
        Currency(code: "KYD", name: "currency_cayman_islands_dollar", type: .fiat, symbol: "$"),
        Currency(code: "KZT", name: "currency_kazakhstani_tenge", type: .fiat, symbol: "₸"),
        Currency(code: "LAK", name: "currency_laotian_kip", type: .fiat, symbol: "₭"),
        Currency(code: "LBP", name: "currency_lebanese_pound", type: .fiat, symbol: "ل.ل"),
        Currency(code: "LKR", name: "currency_sri_lankan_rupee", type: .fiat, symbol: "₨"),
        Currency(code: "LRD", name: "currency_liberian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "LSL", name: "currency_lesotho_loti", type: .fiat, symbol: "M"),
        Currency(code: "LTL", name: "currency_lithuanian_litas", type: .fiat, symbol: "Lt"),
        Currency(code: "LVL", name: "currency_latvian_lats", type: .fiat, symbol: "Ls"),
        Currency(code: "LYD", name: "currency_libyan_dinar", type: .fiat, symbol: "د.ل"),
        Currency(code: "MAD", name: "currency_moroccan_dirham", type: .fiat, symbol: "د.م."),
        Currency(code: "MDL", name: "currency_moldovan_leu", type: .fiat, symbol: "L"),
        Currency(code: "MGA", name: "currency_malagasy_ariary", type: .fiat, symbol: "Ar"),
        Currency(code: "MKD", name: "currency_macedonian_denar", type: .fiat, symbol: "ден"),
        Currency(code: "MMK", name: "currency_myanmar_kyat", type: .fiat, symbol: "K"),
        Currency(code: "MNT", name: "currency_mongolian_tugrik", type: .fiat, symbol: "₮"),
        Currency(code: "MOP", name: "currency_macanese_pataca", type: .fiat, symbol: "MOP$"),
        Currency(code: "MRU", name: "currency_mauritanian_ouguiya", type: .fiat, symbol: "UM"),
        Currency(code: "MUR", name: "currency_mauritian_rupee", type: .fiat, symbol: "₨"),
        Currency(code: "MVR", name: "currency_maldivian_rufiyaa", type: .fiat, symbol: "Rf"),
        Currency(code: "MWK", name: "currency_malawian_kwacha", type: .fiat, symbol: "MK"),
        Currency(code: "MYR", name: "currency_malaysian_ringgit", type: .fiat, symbol: "RM"),
        Currency(code: "MZN", name: "currency_mozambican_metical", type: .fiat, symbol: "MT"),
        Currency(code: "NAD", name: "currency_namibian_dollar", type: .fiat, symbol: "$"),
        Currency(code: "NGN", name: "currency_nigerian_naira", type: .fiat, symbol: "₦"),
        Currency(code: "NIO", name: "currency_nicaraguan_cordoba", type: .fiat, symbol: "C$"),
        Currency(code: "NPR", name: "currency_nepalese_rupee", type: .fiat, symbol: "₨"),
        Currency(code: "OMR", name: "currency_omani_rial", type: .fiat, symbol: "ر.ع."),
        Currency(code: "PAB", name: "currency_panamanian_balboa", type: .fiat, symbol: "B/."),
        Currency(code: "PEN", name: "currency_peruvian_sol", type: .fiat, symbol: "S/."),
        Currency(code: "PGK", name: "currency_papua_new_guinean_kina", type: .fiat, symbol: "K"),
        Currency(code: "PHP", name: "currency_philippine_peso", type: .fiat, symbol: "₱"),
        Currency(code: "PKR", name: "currency_pakistani_rupee", type: .fiat, symbol: "₨"),
        Currency(code: "PLN", name: "currency_polish_zloty", type: .fiat, symbol: "zł"),
        Currency(code: "PYG", name: "currency_paraguayan_guarani", type: .fiat, symbol: "₲"),
        Currency(code: "QAR", name: "currency_qatari_riyal", type: .fiat, symbol: "ر.ق"),
        Currency(code: "RON", name: "currency_romanian_leu", type: .fiat, symbol: "lei"),
        Currency(code: "RSD", name: "currency_serbian_dinar", type: .fiat, symbol: "дин."),
        Currency(code: "RWF", name: "currency_rwandan_franc", type: .fiat, symbol: "FRw"),
        Currency(code: "SAR", name: "currency_saudi_riyal", type: .fiat, symbol: "ر.س"),
        Currency(code: "SBD", name: "currency_solomon_islands_dollar", type: .fiat, symbol: "$"),
        Currency(code: "SCR", name: "currency_seychellois_rupee", type: .fiat, symbol: "₨"),
        Currency(code: "SDG", name: "currency_sudanese_pound", type: .fiat, symbol: "ج.س."),
        Currency(code: "SHP", name: "currency_saint_helena_pound", type: .fiat, symbol: "£"),
        Currency(code: "SLL", name: "currency_sierra_leonean_leone", type: .fiat, symbol: "Le"),
        Currency(code: "SOS", name: "currency_somali_shilling", type: .fiat, symbol: "Sh"),
        Currency(code: "SRD", name: "currency_surinamese_dollar", type: .fiat, symbol: "$"),
        Currency(code: "SSP", name: "currency_south_sudanese_pound", type: .fiat, symbol: "£"),
        Currency(code: "STD", name: "currency_sao_tome_and_principe_dobra", type: .fiat, symbol: "Db"),
        Currency(code: "SVC", name: "currency_salvadoran_colon", type: .fiat, symbol: "₡"),
        Currency(code: "SYP", name: "currency_syrian_pound", type: .fiat, symbol: "£S"),
        Currency(code: "SZL", name: "currency_swazi_lilangeni", type: .fiat, symbol: "L"),
        Currency(code: "THB", name: "currency_thai_baht", type: .fiat, symbol: "฿"),
        Currency(code: "TJS", name: "currency_tajikistani_somoni", type: .fiat, symbol: "ЅМ"),
        Currency(code: "TMT", name: "currency_turkmenistan_manat", type: .fiat, symbol: "T"),
        Currency(code: "TND", name: "currency_tunisian_dinar", type: .fiat, symbol: "د.ت"),
        Currency(code: "TOP", name: "currency_tongan_paanga", type: .fiat, symbol: "T$"),
        Currency(code: "TRY", name: "currency_turkish_lira", type: .fiat, symbol: "₺"),
        Currency(code: "TTD", name: "currency_trinidad_and_tobago_dollar", type: .fiat, symbol: "TT$"),
        Currency(code: "TVD", name: "currency_tuvaluan_dollar", type: .fiat, symbol: "$"),
        Currency(code: "TWD", name: "currency_taiwan_new_dollar", type: .fiat, symbol: "NT$"),
        Currency(code: "TZS", name: "currency_tanzanian_shilling", type: .fiat, symbol: "TSh"),
        Currency(code: "UAH", name: "currency_ukrainian_hryvnia", type: .fiat, symbol: "₴"),
        Currency(code: "UGX", name: "currency_ugandan_shilling", type: .fiat, symbol: "USh"),
        Currency(code: "UYU", name: "currency_uruguayan_peso", type: .fiat, symbol: "$U"),
        Currency(code: "UZS", name: "currency_uzbekistani_som", type: .fiat, symbol: "сўм"),
        Currency(code: "VES", name: "currency_venezuelan_bolivar", type: .fiat, symbol: "Bs.S"),
        Currency(code: "VND", name: "currency_vietnamese_dong", type: .fiat, symbol: "₫"),
        Currency(code: "VUV", name: "currency_vanuatu_vatu", type: .fiat, symbol: "VT"),
        Currency(code: "WST", name: "currency_samoan_tala", type: .fiat, symbol: "WS$"),
        Currency(code: "XAF", name: "currency_central_african_cfa_franc", type: .fiat, symbol: "FCFA"),
        Currency(code: "XCD", name: "currency_east_caribbean_dollar", type: .fiat, symbol: "$"),
        Currency(code: "XOF", name: "currency_west_african_cfa_franc", type: .fiat, symbol: "CFA"),
        Currency(code: "XPF", name: "currency_cfp_franc", type: .fiat, symbol: "₣"),
        Currency(code: "YER", name: "currency_yemeni_rial", type: .fiat, symbol: "﷼"),
        Currency(code: "ZAR", name: "currency_south_african_rand", type: .fiat, symbol: "R"),
        Currency(code: "ZMW", name: "currency_zambian_kwacha", type: .fiat, symbol: "ZK"),
        Currency(code: "ZWL", name: "currency_zimbabwean_dollar", type: .fiat, symbol: "Z$")

    ]

    static let cryptoCurrencies: [Currency] = [
        // TOP 10: By market cap ranking (January 2025)
        Currency(code: "BTC", name: "Bitcoin", type: .crypto, symbol: "₿"),
        Currency(code: "ETH", name: "Ethereum", type: .crypto, symbol: "Ξ"),
        Currency(code: "USDT", name: "Tether", type: .crypto, symbol: "₮"),
        Currency(code: "XRP", name: "XRP", type: .crypto, symbol: "✕"),
        Currency(code: "BNB", name: "BNB", type: .crypto, symbol: " BNB"),
        Currency(code: "SOL", name: "Solana", type: .crypto, symbol: "SOL"),
        Currency(code: "USDC", name: "USD Coin", type: .crypto, symbol: "USDC"),
        Currency(code: "DOGE", name: "Dogecoin", type: .crypto, symbol: "Ɖ"),
        Currency(code: "ADA", name: "Cardano", type: .crypto, symbol: "₳"),
        Currency(code: "TRX", name: "TRON", type: .crypto, symbol: "TRX"),

        // TIER 2: Major altcoins (Top 11-25)
        Currency(code: "AVAX", name: "Avalanche", type: .crypto, symbol: "AVAX"),
        Currency(code: "TON", name: "Toncoin", type: .crypto, symbol: "TON"),
        Currency(code: "LINK", name: "Chainlink", type: .crypto, symbol: "LINK"),
        Currency(code: "DOT", name: "Polkadot", type: .crypto, symbol: "●"),
        Currency(code: "WBTC", name: "Wrapped Bitcoin", type: .crypto, symbol: "WBTC"),
        Currency(code: "LTC", name: "Litecoin", type: .crypto, symbol: "Ł"),
        Currency(code: "UNI", name: "Uniswap", type: .crypto, symbol: "UNI"),
        Currency(code: "ATOM", name: "Cosmos", type: .crypto, symbol: "ATOM"),
        Currency(code: "ICP", name: "Internet Computer", type: .crypto, symbol: "ICP"),
        Currency(code: "STETH", name: "Lido Staked Ether", type: .crypto, symbol: "stETH"),

        // TIER 3: Rest by popularity/volume (alphabetical)
        Currency(code: "AAVE", name: "Aave", type: .crypto, symbol: "AAVE"),
        Currency(code: "ALGO", name: "Algorand", type: .crypto, symbol: "Ⱥ"),
        Currency(code: "APT", name: "Aptos", type: .crypto, symbol: "APT"),
        Currency(code: "ARB", name: "Arbitrum", type: .crypto, symbol: "ARB"),
        Currency(code: "AXS", name: "Axie Infinity", type: .crypto, symbol: "AXS"),
        Currency(code: "BCH", name: "Bitcoin Cash", type: .crypto, symbol: "BCH"),
        Currency(code: "BGB", name: "Bitget Token", type: .crypto, symbol: "BGB"),
        Currency(code: "BUSD", name: "Binance USD", type: .crypto, symbol: "BUSD"),
        Currency(code: "CFX", name: "Conflux", type: .crypto, symbol: "CFX"),
        Currency(code: "CRO", name: "Cronos", type: .crypto, symbol: "CRO"),
        Currency(code: "DAI", name: "Dai", type: .crypto, symbol: "◈"),
        Currency(code: "EGLD", name: "MultiversX", type: .crypto, symbol: "ℯ"),
        Currency(code: "ETC", name: "Ethereum Classic", type: .crypto, symbol: "⟠"),
        Currency(code: "FIL", name: "Filecoin", type: .crypto, symbol: "Fil"),
        Currency(code: "FLR", name: "Flare", type: .crypto, symbol: "FLR"),
        Currency(code: "GRT", name: "The Graph", type: .crypto, symbol: "GRT"),
        Currency(code: "HBAR", name: "Hedera", type: .crypto, symbol: "ℏ"),
        Currency(code: "INJ", name: "Injective", type: .crypto, symbol: "INJ"),
        Currency(code: "JLP", name: "Jupiter", type: .crypto, symbol: "JUP"),
        Currency(code: "KAS", name: "Kaspa", type: .crypto, symbol: "KAS"),
        Currency(code: "LDO", name: "Lido DAO", type: .crypto, symbol: "LDO"),
        Currency(code: "LEO", name: "UNUS SED LEO", type: .crypto, symbol: "LEO"),
        Currency(code: "LUNC", name: "Terra Luna Classic", type: .crypto, symbol: "LUNC"),
        Currency(code: "METH", name: "Mantle Staked Ether", type: .crypto, symbol: "mETH"),
        Currency(code: "NEAR", name: "NEAR Protocol", type: .crypto, symbol: "NEAR"),
        Currency(code: "OP", name: "Optimism", type: .crypto, symbol: "OP"),
        Currency(code: "POL", name: "Polygon", type: .crypto, symbol: "POL"),
        Currency(code: "PYTH", name: "Pyth Network", type: .crypto, symbol: "PYTH"),
        Currency(code: "QNT", name: "Quant", type: .crypto, symbol: "QNT"),
        Currency(code: "RENDER", name: "Render", type: .crypto, symbol: "RENDER"),
        Currency(code: "SEI", name: "Sei", type: .crypto, symbol: "SEI"),
        Currency(code: "SHIB", name: "Shiba Inu", type: .crypto, symbol: "SHIB"),
        Currency(code: "STX", name: "Stacks", type: .crypto, symbol: "STX"),
        Currency(code: "SUI", name: "Sui", type: .crypto, symbol: "SUI"),
        Currency(code: "TAO", name: "Bittensor", type: .crypto, symbol: "τ"),
        Currency(code: "THETA", name: "Theta Network", type: .crypto, symbol: "THETA"),
        Currency(code: "TIA", name: "Celestia", type: .crypto, symbol: "TIA"),
        Currency(code: "VET", name: "VeChain", type: .crypto, symbol: "VET"),
        Currency(code: "WBT", name: "WhiteBIT Token", type: .crypto, symbol: "WBT"),
        Currency(code: "XLM", name: "Stellar", type: .crypto, symbol: "🚀"),
        Currency(code: "XMR", name: "Monero", type: .crypto, symbol: "ɱ"),
        Currency(code: "XTZ", name: "Tezos", type: .crypto, symbol: "ꜩ"),
        Currency(code: "ZEC", name: "Zcash", type: .crypto, symbol: "ⓩ")
    ]

    static func getCurrencies(for type: CurrencyType) -> [Currency] {
        switch type {
        case .fiat:
            return fiatCurrencies
        case .crypto:
            return cryptoCurrencies
        }
    }

    static func findCurrency(by code: String) -> Currency? {
        let allCurrencies = fiatCurrencies + cryptoCurrencies
        return allCurrencies.first { $0.code == code }
    }

    static func searchCurrencies(query: String, type: CurrencyType? = nil) -> [Currency] {
        let currencies = type == nil ? (fiatCurrencies + cryptoCurrencies) : getCurrencies(for: type!)

        if query.isEmpty {
            return currencies
        }

        let lowercasedQuery = query.lowercased()

        return currencies.filter { currency in
            if currency.code.lowercased().contains(lowercasedQuery) {
                return true
            }

            let localizedName = currency.dynamicLocalizedName

            return localizedName.lowercased().contains(lowercasedQuery)
        }
    }
}
