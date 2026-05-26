import SwiftUI

enum NavigationAppearance {
    private static let titleSize: CGFloat = 18
    private static let largeTitleSize: CGFloat = 34

    static func configureFonts() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.font: UIFont.rounded(ofSize: largeTitleSize, weight: .bold)]
        appearance.titleTextAttributes = [.font: UIFont.rounded(ofSize: titleSize, weight: .semibold)]

        let scrollEdgeAppearance = appearance.copy()

        appearance.configureWithDefaultBackground()
        scrollEdgeAppearance.configureWithTransparentBackground()

        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

extension UIFont {
    static func rounded(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
        let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor
        return UIFont(descriptor: descriptor.withDesign(.rounded) ?? descriptor, size: size)
    }
}
