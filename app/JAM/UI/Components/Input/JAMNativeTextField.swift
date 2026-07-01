import SwiftUI
import AppKit

struct JAMNativeTextField: NSViewRepresentable {

    @Binding var text: String

    var onSubmit: () -> Void

    var onUpArrow: (() -> Void)? = nil
    var onDownArrow: (() -> Void)? = nil
    var onTab: (() -> Void)? = nil
    var onEscape: (() -> Void)? = nil

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSTextField {

        let field = JAMTextField()

        field.delegate = context.coordinator

        field.onUpArrow = {
            self.onUpArrow?()
        }

        field.onDownArrow = {
            self.onDownArrow?()
        }

        field.onTab = {
            self.onTab?()
        }

        field.onEscape = {
            self.onEscape?()
        }

        field.onReturn = {
            self.onSubmit()
        }

        field.isBordered = false
        field.isBezeled = false
        field.drawsBackground = false
        field.focusRingType = .none

        field.font = .systemFont(ofSize: 24, weight: .medium)
        field.textColor = .white

        return field
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {

        if nsView.stringValue != text {
            nsView.stringValue = text
        }

    }

    final class Coordinator: NSObject, NSTextFieldDelegate {

        var parent: JAMNativeTextField

        init(_ parent: JAMNativeTextField) {
            self.parent = parent
        }

        func controlTextDidChange(_ notification: Notification) {

            guard let field = notification.object as? NSTextField else {
                return
            }

            parent.text = field.stringValue

        }

    }

}
