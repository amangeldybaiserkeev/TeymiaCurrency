import SwiftUI

struct AboutSection: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Section {
            rateButton
            shareButton
            termsButton
            privacyButton
        }
    }

    private var rateButton: some View {
        Button {
            openURL(AppConfig.rateAppURL)
        } label: {
            SettingsRowLabel(option: .rate)
        }
    }

    private var shareButton: some View {
        ShareLink(item: AppConfig.appStoreURL) {
            SettingsRowLabel(option: .share)
        }
    }

    private var termsButton: some View {
        Button {
            openURL(AppConfig.termsURL)
        } label: {
            SettingsRowLabel(option: .terms)
        }
    }

    private var privacyButton: some View {
        Button {
            openURL(AppConfig.privacyURL)
        } label: {
            SettingsRowLabel(option: .privacy)
        }
    }
}
