import Foundation

struct SettingsAvailability: Hashable {

    let minimumMacOSMajorVersion: Int?

    let requiresBattery: Bool

    let requiresTouchID: Bool

    let requiresAppleSilicon: Bool

    init(
        minimumMacOSMajorVersion: Int? = nil,
        requiresBattery: Bool = false,
        requiresTouchID: Bool = false,
        requiresAppleSilicon: Bool = false
    ) {
        self.minimumMacOSMajorVersion =
            minimumMacOSMajorVersion

        self.requiresBattery =
            requiresBattery

        self.requiresTouchID =
            requiresTouchID

        self.requiresAppleSilicon =
            requiresAppleSilicon
    }


    // MARK: - Default

    static let universal =
        SettingsAvailability()


    // MARK: - Availability Check

    func isAvailable(
        in environment: SettingsEnvironment
    ) -> Bool {

        if let minimumMacOSMajorVersion {

            guard environment.isRunning(
                macOSMajorVersion:
                    minimumMacOSMajorVersion
            ) else {
                return false
            }
        }


        if requiresBattery &&
            !environment.hasBattery {

            return false
        }


        if requiresTouchID &&
            !environment.hasTouchID {

            return false
        }


        if requiresAppleSilicon &&
            !environment.isAppleSilicon {

            return false
        }


        return true
    }
}
