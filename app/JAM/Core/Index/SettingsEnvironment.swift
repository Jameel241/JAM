import Foundation
import IOKit.ps
import LocalAuthentication

struct SettingsEnvironment {

    static let current = SettingsEnvironment()

    let operatingSystemVersion: OperatingSystemVersion
    let hasBattery: Bool
    let hasTouchID: Bool
    let isAppleSilicon: Bool

    private init() {

        operatingSystemVersion =
            ProcessInfo.processInfo.operatingSystemVersion

        hasBattery =
            Self.detectBattery()

        hasTouchID =
            Self.detectTouchID()

        isAppleSilicon =
            Self.detectAppleSilicon()
    }


    // MARK: - macOS Version


    func isRunning(
        macOSMajorVersion version: Int
    ) -> Bool {

        operatingSystemVersion.majorVersion >= version
    }


    // MARK: - Battery


    private static func detectBattery() -> Bool {

        guard let snapshot =
            IOPSCopyPowerSourcesInfo()?
                .takeRetainedValue()
        else {
            return false
        }

        guard let sources =
            IOPSCopyPowerSourcesList(snapshot)?
                .takeRetainedValue() as? [CFTypeRef]
        else {
            return false
        }

        return sources.contains { source in

            guard let description =
                IOPSGetPowerSourceDescription(
                    snapshot,
                    source
                )?
                .takeUnretainedValue()
                as? [String: Any]
            else {
                return false
            }

            return description[
                kIOPSTypeKey
            ] as? String == kIOPSInternalBatteryType
        }
    }


    // MARK: - Touch ID


    private static func detectTouchID() -> Bool {

        let context = LAContext()

        var error: NSError?

        _ = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )

        return context.biometryType == .touchID
    }


    // MARK: - Apple Silicon


    private static func detectAppleSilicon() -> Bool {

        #if arch(arm64)

        return true

        #else

        return false

        #endif
    }
}
