import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                ThemeRow()
                AppIconRow()
                HapticsRow()
                LanguageRow()
                AboutSection()
            }
            .groupBackground()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { CloseToolbarButton() }
        }
    }
}
