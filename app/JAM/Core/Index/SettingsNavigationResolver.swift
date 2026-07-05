import Foundation

enum SettingsNavigationResolver {

    static func url(
        for destination: SettingsDestination
    ) -> URL? {

        switch destination {

        case .pane(let identifier):

            return settingsURL(
                identifier: identifier
            )


        case .nested(let pane, let anchor):

            return settingsURL(
                identifier: pane,
                anchor: anchor
            )


        case .fallback(
            let primary,
            let fallback
        ):

            return url(for: primary)
                ?? url(for: fallback)


        case .systemSettings:

            return URL(
                string: "x-apple.systempreferences:"
            )
        }
    }


    // MARK: - URL Construction


    private static func settingsURL(
        identifier: String,
        anchor: String? = nil
    ) -> URL? {

        var value =
            "x-apple.systempreferences:\(identifier)"

        if let anchor,
           !anchor.isEmpty {

            value += "?\(anchor)"
        }

        return URL(string: value)
    }
}
