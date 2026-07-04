import AppKit

final class JAMTextField: NSTextField {

    var onTab: (() -> Void)?
    var onEscape: (() -> Void)?
    var onUpArrow: (() -> Void)?
    var onDownArrow: (() -> Void)?
    var onReturn: (() -> Void)?

    override func doCommand(
        by selector: Selector
    ) {

        switch selector {

        case #selector(NSResponder.moveUp(_:)):
            onUpArrow?()

        case #selector(NSResponder.moveDown(_:)):
            onDownArrow?()

        case #selector(NSResponder.insertTab(_:)):
            onTab?()

        case #selector(NSResponder.cancelOperation(_:)):
            onEscape?()

        case #selector(NSResponder.insertNewline(_:)):
            onReturn?()

        default:
            super.doCommand(by: selector)

        }

    }

}
