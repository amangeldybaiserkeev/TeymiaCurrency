import SwiftUI

struct HapticsRow: View {
    @AppStorage(AppStorageKeys.hapticEnabled) private var isHapticsEnabled = true

    var body: some View {
        Toggle(isOn: $isHapticsEnabled) {
            SettingsRowLabel(option: .haptics)
                .symbolEffect(.bounce.byLayer, value: isHapticsEnabled)
        }
    }
}
