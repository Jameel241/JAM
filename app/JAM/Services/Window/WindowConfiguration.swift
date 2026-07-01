import CoreGraphics

struct WindowConfiguration {

    let width: CGFloat
    let height: CGFloat

    let isResizable: Bool
    let isFloating: Bool

}

extension WindowConfiguration {

    static let command = WindowConfiguration(
        width: 760,
        height: 560,
        isResizable: false,
        isFloating: true
    )

    static let dashboard = WindowConfiguration(
        width: 1100,
        height: 700,
        isResizable: true,
        isFloating: false
    )

}
