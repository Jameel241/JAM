import AppKit

final class JAMTextField: NSTextField {

    var onTab: (() -> Void)?
    var onEscape: (() -> Void)?
    var onUpArrow: (() -> Void)?
    var onDownArrow: (() -> Void)?
    var onReturn: (() -> Void)?

    override func keyDown(with event: NSEvent) {

        switch event.keyCode {

        case 48: // Tab
            onTab?()

        case 53: // Escape
            onEscape?()

        case 126: // ↑
            onUpArrow?()

        case 125: // ↓
            onDownArrow?()

        case 36: // Return
            onReturn?()

        default:
            super.keyDown(with: event)

        }

    }

}
