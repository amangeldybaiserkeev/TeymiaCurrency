import SwiftUI

enum AppIcon: String, CaseIterable, Identifiable {
    case main = "AppIcon"
    case globe = "AppIcon-Globe"
    case gold = "AppIcon-Gold"
    case white = "AppIcon-White"
    case greenDollar = "AppIcon-GreenDollar"
    case cash = "AppIcon-Cash"
    case blue = "AppIcon-Blue"
    case purple = "AppIcon-Purple"
    case yuan = "AppIcon-Yuan"
    
    var id: String { rawValue }

    var title: LocalizedStringKey {
        switch self {
        case .main: "AppIcon"
        case .globe: "AppIcon-Globe"
        case .gold: "AppIcon-Gold"
        case .white: "AppIcon-White"
        case .greenDollar: "AppIcon-GreenDollar"
        case .cash: "AppIcon-Cash"
        case .blue: "AppIcon-Blue"
        case .purple: "AppIcon-Purple"
        case .yuan: "AppIcon-Yuan"
        }
    }

    var name: String? {
        self == .main ? nil : rawValue
    }

    var previewImageName: String {
        "Preview-\(rawValue)"
    }
}
