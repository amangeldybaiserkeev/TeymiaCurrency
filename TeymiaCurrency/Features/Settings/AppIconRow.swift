import SwiftUI

struct AppIconRow: View {

    var body: some View {
        NavigationLink {
            AppIconView()
        } label: {
            Label("App Icon", icon: .appIcon)
        }
    }
}

private struct AppIconView: View {
    private let iconManager = AppIconManager()
    @State private var haptic = 0

    var body: some View {
        List {
            ForEach(AppIcon.allCases) { icon in
                let isSelected = iconManager.currentIcon == icon

                Button {
                    iconManager.setAppIcon(icon)
                    haptic += 1
                } label: {
                    HStack(spacing: Spacing.reg) {
                        AppIconImage(icon: icon)

                        Text(icon.title)

                        Spacer()

                        if isSelected { SelectionCheckmark() }
                    }
                    .sensoryFeedback(.selection, trigger: haptic)
                }
            }
        }
        .animation(.smooth, value: iconManager.currentIcon)
        .navigationTitle("App Icon")
    }
}

private struct AppIconImage: View {
    let icon: AppIcon

    var body: some View {
        Image(icon.previewImageName)
            .resizable()
            .frame(width: 48, height: 48)
    }
}
