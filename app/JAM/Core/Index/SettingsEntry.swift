import Foundation

struct SettingsEntry: Identifiable, Hashable {
    
    let destinationVariants: [SettingsDestinationVariant]

    let id: String

    let displayName: String

    let aliases: [String]

    let category: String

    /// Describes where this setting lives
    /// inside System Settings.
    ///
    /// Example:
    /// ["Privacy & Security", "Microphone"]
    let hierarchy: [String]

    /// Describes where JAM should navigate
    /// when this setting is opened.
    let destination: SettingsDestination

    /// Describes what JAM is capable
    /// of doing with this setting.
    let capability: SettingCapability
    
    let availability: SettingsAvailability

    init(
        id: String,
        displayName: String,
        aliases: [String] = [],
        category: String,
        hierarchy: [String] = [],
        destination: SettingsDestination,
        capability: SettingCapability = .navigation,
        availability: SettingsAvailability = .universal,
        destinationVariants: [SettingsDestinationVariant] = []
    ) {
        self.id = id
        self.displayName = displayName
        self.aliases = aliases
        self.category = category
        self.hierarchy = hierarchy
        self.destination = destination
        self.capability = capability
        self.availability = availability
        self.destinationVariants = destinationVariants
    }
    // MARK: - Resolved Destination

    func resolvedDestination(
        environment: SettingsEnvironment = .current
    ) -> SettingsDestination {

        guard !destinationVariants.isEmpty else {
            return destination
        }

        return SettingsDestinationResolver.resolve(
            variants: destinationVariants,
            fallback: destination,
            environment: environment
        )
    }
}


// MARK: - Setting Capability

enum SettingCapability: String, Hashable {

    /// JAM opens the most accurate
    /// System Settings destination.
    case navigation

    /// JAM can display and change
    /// an on/off value.
    case toggle

    /// JAM can display and change
    /// a numeric value.
    case slider

    /// JAM can display multiple choices.
    ///
    /// Example:
    /// Light / Dark / Auto
    case choice

    /// JAM can execute a specific action.
    case action
}
