import SwiftUI

struct CalculatorNumberpadView: View {
    let onKeyPress: (NumberpadAction) -> Void

    private let firstRow: [NumberpadAction] = [.clear, .dismiss, .divide]
    private let otherRows: [[NumberpadAction]] = [
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.decimal, .zero, .delete, .equals]
    ]

    var body: some View {
        Grid(horizontalSpacing: Spacing.xs, verticalSpacing: Spacing.xs) {
            GridRow {
                ForEach(firstRow.indices, id: \.self) { index in
                    let action = firstRow[index]
                    KeyButton(action: action, onPress: onKeyPress)
                        .gridCellColumns(action == .dismiss ? 2 : 1)
                }
            }

            ForEach(0..<otherRows.count, id: \.self) { rowIndex in
                GridRow {
                    ForEach(otherRows[rowIndex], id: \.self) { action in
                        KeyButton(action: action, onPress: onKeyPress)
                    }
                }
            }
        }
        .padding(Spacing.xs)
        .padding(.top, Spacing.xl)
        .padding(.bottom, Spacing.sm)
        .modifier(AdaptiveNumberpadBackground())
        .frame(height: 320)
    }
}

private struct KeyButton: View {
    let action: NumberpadAction
    let onPress: (NumberpadAction) -> Void

    @GestureState private var isPressed = false
    @State private var haptic = 0

    private let iconSize = IconSize.reg
    private let cornerRadius = Radius.xs

    var body: some View {
        Button {
            onPress(action)
            haptic += 1
            UIDevice.current.playInputClick()
        } label: {
            Group {
                if let image = action.systemImage {
                    Image(systemName: image)
                        .imageScale(.small)
                } else {
                    Text(action.displayValue)
                }
            }
            .font(.system(size: iconSize, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(action.backgroundColor)
            .foregroundStyle(action.foregroundColor)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.numberpadStroke, lineWidth: 0.5)
            )
            .scaleEffect(isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.15), value: isPressed)
        }
        .buttonStyle(.plain)
        .appSensoryFeedback(.selection, trigger: haptic)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
    }
}

private struct AdaptiveNumberpadBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
        } else {
            content
                .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    CalculatorNumberpadView { action in
        print("button pressed")
    }
}
