import SwiftUI

struct ThemeRow: View {
    @AppStorage("Theme") private var theme: Theme = .system

    var body: some View {
        Picker(selection: $theme) {
            ForEach(Theme.allCases, id: \.self) { mode in
                Text(mode.localizedName).tag(mode)
            }
        } label: {
            Label {
                Text("Appearance")
            } icon: {
                Image(systemName: theme.systemImage)
            }
            .contentTransition(.symbolEffect(.replace))
        }
        .pickerStyle(.menu)
        .tint(.secondary)
    }
}
