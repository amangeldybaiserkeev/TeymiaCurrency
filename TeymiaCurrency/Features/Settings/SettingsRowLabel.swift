import SwiftUI

enum SettingsOption: String {
    case appIcon = "app"
    case language = "globe.americas.fill"
    case haptics = "waveform"
    case rate = "star"
    case share = "square.and.arrow.up"
    case privacy = "lock"
    case terms = "document"

    var iconName: String { self.rawValue }

    var title: LocalizedStringKey {
        switch self {
        case .appIcon: "App Icon"
        case .language: "Language"
        case .haptics: "Haptics"
        case .rate: "Rate"
        case .share: "Share"
        case .privacy: "Privacy"
        case .terms: "Terms"
        }
    }
}

struct SettingsRowLabel: View {
    let option: SettingsOption

    var body: some View {
        Label {
            Text(option.title)
        } icon: {
            Image(systemName: option.iconName)
                .font(.callout)
                .fontWeight(.medium)
        }
    }
}
