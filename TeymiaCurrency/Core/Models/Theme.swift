import SwiftUI

enum Theme: String, CaseIterable {
    case system
    case light
    case dark

    var colorScheme: ColorScheme? {
        switch self {
        case .system: .none
        case .light: .light
        case .dark: .dark
        }
    }

    var localizedName: LocalizedStringKey {
        switch self {
        case .system: "System"
        case .light: "Light"
        case .dark: "Dark"
        }
    }

    var iconName: String {
        switch self {
        case .system: "swirl.circle.righthalf.filled"
        case .light: "sun.max"
        case .dark: "moon.stars"
        }
    }
}
