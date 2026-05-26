import SwiftUI

struct CloseToolbarButton: ToolbarContent {
    @Environment(\.dismiss) private var dismiss

    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            if #available(iOS 26.0, *) {
                Button(role: .close) {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            } else {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundStyle(.secondary)
                        .padding(8)
                        .background(.secondary.opacity(0.1), in: .circle)
                }
            }
        }
    }
}

struct PlusToolbarButton: ToolbarContent {
    let namespace: Namespace.ID
    let action: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                action()
            } label: {
                if #available(iOS 26.0, *) {
                    Image(systemName: "plus")
                } else {
                    Image("plus")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.secondary.opacity(0.1), in: .circle)
                }
            }
            .appMatchedTransitionSource(id: AnimationIDs.plusZoom, in: namespace)
        }
    }
}

struct SettingsToolbarButton: ToolbarContent {
    let namespace: Namespace.ID
    let action: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                action()
            } label: {
                if #available(iOS 26.0, *) {
                    Image(systemName: "gearshape")
                } else {
                    Image("gearshape")
                        .font(.caption)
                        .padding(8)
                        .background(.secondary.opacity(0.1), in: .circle)

                }
            }
            .appMatchedTransitionSource(id: AnimationIDs.settingsZoom, in: namespace)
        }
    }
}
