import SwiftUI

struct AboutSection: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Section {
            rateButton
            shareButton
            privacyButton
            termsButton
        }
    }

    private var rateButton: some View {
        Button {
            openURL(AppConfig.rateAppURL)
        } label: {
            Label("Rate", icon: .rate)
        }
    }

    private var shareButton: some View {
        ShareLink(item: AppConfig.appStoreURL) {
            Label("Share", icon: .share)
        }
    }

    private var privacyButton: some View {
        Button {
            openURLInApp(AppConfig.privacyURL)
        } label: {
            Label("Privacy Policy", icon: .privacy)
        }
    }

    private var termsButton: some View {
        Button {
            openURLInApp(AppConfig.termsURL)
        } label: {
            Label("Terms of Service", icon: .terms)
        }
    }

    private func openURLInApp(_ url: URL) {
        if #available(iOS 26.0, *) {
            openURL(url, prefersInApp: true)
        } else {
            openURL(url)
        }
    }
}

private enum AppConfig {
    static let appStoreURL = createURL("https://apps.apple.com/app/id6752235997")
    static let rateAppURL = createURL("https://apps.apple.com/app/id6752235997?action=write-review")
    static let privacyURL = createURL("https://www.notion.so/Privacy-Policy-267d5178e65a8017ad5afda2e3f004fc")
    static let termsURL = createURL("https://www.notion.so/Terms-of-Service-267d5178e65a804a9e80d8660c798b57")

    private static func createURL(_ string: String) -> URL {
        URL(string: string) ?? URL(fileURLWithPath: "")
    }
}
