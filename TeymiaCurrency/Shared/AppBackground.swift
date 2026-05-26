import SwiftUI

struct GroupBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color.groupBackground)
    }
}

extension View {
    func groupBackground() -> some View {
        modifier(GroupBackground())
    }
}
