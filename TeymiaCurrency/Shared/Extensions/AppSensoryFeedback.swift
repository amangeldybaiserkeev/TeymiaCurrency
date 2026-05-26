import SwiftUI

extension View {
    func appSensoryFeedback<T: Equatable>(_ feedback: SensoryFeedback, trigger: T) -> some View {
        self.sensoryFeedback(trigger: trigger) { _, _ in
            let isEnabled = UserDefaults.standard.object(forKey: AppStorageKeys.hapticEnabled) as? Bool ?? true
            return isEnabled ? feedback : nil
        }
    }
}
