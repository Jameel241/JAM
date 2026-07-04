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
        SearchFieldRegistry.shared.textField = field
      
        field.delegate = context.coordinator
        field.target = context.coordinator
        field.action = #selector(Coordinator.submit)

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

    func updateNSView(
        _ nsView: NSTextField,
        context: Context
    ) {

        if nsView.stringValue != text {

            nsView.stringValue = text

            if text.isEmpty,
               let editor = nsView.currentEditor() {

                editor.selectedRange = NSRange(
                    location: 0,
                    length: 0
                )
            }
        }

        SearchFieldRegistry.shared.textField = nsView

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
        func control(
            _ control: NSControl,
            textView: NSTextView,
            doCommandBy commandSelector: Selector
        ) -> Bool {

            switch commandSelector {

            case #selector(NSResponder.moveUp(_:)):
                parent.onUpArrow?()
                return true

            case #selector(NSResponder.moveDown(_:)):
                parent.onDownArrow?()
                return true

            case #selector(NSResponder.insertTab(_:)):
                parent.onTab?()
                return true

            case #selector(NSResponder.cancelOperation(_:)):
                parent.onEscape?()
                return true

            case #selector(NSResponder.insertNewline(_:)):
                parent.onSubmit()
                return true

            default:
                return false

            }

        }
        @objc
        func submit() {

            print("submit action")

            parent.onSubmit()

        }

    }

}
