import Foundation

enum SettingsDestinationResolver {

    static func resolve(
        variants: [SettingsDestinationVariant],
        fallback: SettingsDestination = .systemSettings,
        environment: SettingsEnvironment = .current
    ) -> SettingsDestination {

        let compatibleVariants =
            variants.filter {
                $0.isCompatible(
                    with: environment
                )
            }

        guard !compatibleVariants.isEmpty else {
            return fallback
        }

        let bestVariant =
            compatibleVariants.sorted {

                let firstMinimum =
                    $0.minimumMacOSMajorVersion ?? Int.min

                let secondMinimum =
                    $1.minimumMacOSMajorVersion ?? Int.min

                return firstMinimum > secondMinimum
            }
            .first

        return bestVariant?.destination
            ?? fallback
    }
}
