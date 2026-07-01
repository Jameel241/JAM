import SwiftUI

enum JAMColors {

    // MARK: - Backgrounds

    static let background = Color(nsColor: .windowBackgroundColor)

    static let surface = Color.white.opacity(0.05)

    static let elevatedSurface = Color.white.opacity(0.08)

    // MARK: - Borders

    static let border = Color.white.opacity(0.12)

    // MARK: - Text

    static let primaryText = Color.primary

    static let secondaryText = Color.secondary

    // MARK: - Accent

    static let accent = Color.accentColor

    // MARK: - Status

    static let success = Color.green

    static let warning = Color.orange

    static let error = Color.red
}
