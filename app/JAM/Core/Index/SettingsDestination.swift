import Foundation

indirect enum SettingsDestination: Hashable {

    /// Opens a known System Settings pane.
    case pane(String)

    /// Opens a known nested System Settings destination.
    case nested(
        pane: String,
        anchor: String
    )

    /// Uses the primary destination when supported,
    /// otherwise falls back to another destination.
    case fallback(
        primary: SettingsDestination,
        fallback: SettingsDestination
    )

    /// Opens System Settings itself.
    case systemSettings
}
