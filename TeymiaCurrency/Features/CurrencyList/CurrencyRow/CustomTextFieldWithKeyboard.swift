import SwiftUI
import UIKit

struct CustomTextFieldWithKeyboard<KeyboardContent: View>: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let keyboardContent: KeyboardContent

    init(text: Binding<String>, placeholder: String = "0", @ViewBuilder keyboardContent: () -> KeyboardContent) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardContent = keyboardContent()
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.font = .roundedSystemFont(ofSize: 28, weight: .semibold)
        textField.textAlignment = .right
        textField.keyboardType = .numberPad

        let hostingController = UIHostingController(rootView: keyboardContent)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: hostingController.view.intrinsicContentSize.width, height: 320)
        hostingController.view.backgroundColor = .clear
        hostingController.view.clipsToBounds = true
        textField.inputView = hostingController.view

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextFieldWithKeyboard

        init(_ parent: CustomTextFieldWithKeyboard) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}

private extension UIFont {
    static func roundedSystemFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        return font.fontDescriptor.withDesign(.rounded)
            .map { UIFont(descriptor: $0, size: size) } ?? font
    }
}
