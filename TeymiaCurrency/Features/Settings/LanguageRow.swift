import SwiftUI

struct LanguageRow: View {
    var body: some View {
        Button {
            openAppSettings()
        } label: {
            HStack {
                SettingsRowLabel(option: .language)

                Spacer()
                
                Text(currentLanguage)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private var currentLanguage: String {
        let languageCode = Bundle.main.preferredLocalizations.first ?? "en"
        return Locale.current.localizedString(forLanguageCode: languageCode)?.capitalized ?? languageCode
    }
}
