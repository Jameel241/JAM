import Foundation

struct SettingsDestinationVariant: Hashable {

    let destination: SettingsDestination

    let minimumMacOSMajorVersion: Int?

    let maximumMacOSMajorVersion: Int?

    init(
        destination: SettingsDestination,
        minimumMacOSMajorVersion: Int? = nil,
        maximumMacOSMajorVersion: Int? = nil
    ) {
        self.destination = destination
        self.minimumMacOSMajorVersion =
            minimumMacOSMajorVersion
        self.maximumMacOSMajorVersion =
            maximumMacOSMajorVersion
    }


    // MARK: - Compatibility


    func isCompatible(
        with environment: SettingsEnvironment
    ) -> Bool {

        let currentVersion =
            environment.operatingSystemVersion.majorVersion


        if let minimumMacOSMajorVersion,
           currentVersion < minimumMacOSMajorVersion {

            return false
        }


        if let maximumMacOSMajorVersion,
           currentVersion > maximumMacOSMajorVersion {

            return false
        }


        return true
    }
}
