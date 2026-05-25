import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            ThemeRow()
            AppIconRow()
            LanguageRow()
            AboutSection()
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { CloseToolbarButton() }
    }
}
