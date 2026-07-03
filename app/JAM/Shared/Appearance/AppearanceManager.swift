import AppKit

enum AppearanceManager {

    static func appearance(
        for theme: AppTheme
    ) -> NSAppearance? {

        switch theme {

        case .system:
            return nil

        case .light:
            return NSAppearance(named: .aqua)

        case .dark:
            return NSAppearance(named: .darkAqua)

        }

    }

}
