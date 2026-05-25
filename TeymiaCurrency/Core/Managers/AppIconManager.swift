import SwiftUI

@Observable
@MainActor
final class AppIconManager {
    private(set) var currentIcon: AppIcon = .main

    init() {
        syncWithSystem()
    }

    func syncWithSystem() {
        currentIcon = UIApplication.shared.alternateIconName
            .flatMap(AppIcon.init) ?? .main
    }

    func setAppIcon(_ icon: AppIcon) {
        let newName = icon.name

        guard UIApplication.shared.supportsAlternateIcons,
              UIApplication.shared.alternateIconName != newName else { return }

        currentIcon = icon
        UIApplication.shared.setAlternateIconName(newName) {  [weak self] _ in
            Task { @MainActor in
                self?.syncWithSystem()
            }
        }
    }
}
