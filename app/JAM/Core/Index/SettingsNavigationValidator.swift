import Foundation
import AppKit

#if DEBUG

enum SettingsNavigationValidator {

    // Change only this value when testing a destination.
 
    static let testSettingID: String? = nil
    // MARK: - Run

    static func run() {

        printReport()

        guard let testSettingID else {
            return
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2
        ) {
            openSetting(id: testSettingID)
        }
    }


    // MARK: - Report

    static func printReport(
        registry: SettingsRegistry = .shared,
        environment: SettingsEnvironment = .current
    ) {

        print("")
        print("========== JAM SETTINGS REPORT ==========")
        print("")

        print(
            "macOS:",
            environment.operatingSystemVersion.majorVersion,
            environment.operatingSystemVersion.minorVersion,
            environment.operatingSystemVersion.patchVersion
        )

        print("Battery:", environment.hasBattery)
        print("Touch ID:", environment.hasTouchID)
        print("Apple Silicon:", environment.isAppleSilicon)

        print("")
        print("Available Settings:", registry.entries.count)
        print("")

        for entry in registry.entries {

            let destination =
                entry.resolvedDestination(
                    environment: environment
                )

            let url =
                SettingsNavigationResolver.url(
                    for: destination
                )

            print("SETTING:", entry.displayName)
            print("ID:", entry.id)

            print(
                "Hierarchy:",
                entry.hierarchy.joined(
                    separator: " → "
                )
            )

            print(
                "Capability:",
                entry.capability.rawValue
            )

            print(
                "Destination:",
                destination
            )

            print(
                "URL:",
                url?.absoluteString ?? "INVALID URL"
            )

            print("-----------------------------------------")
        }

        print("")
        print("========== END SETTINGS REPORT ==========")
        print("")
    }


    // MARK: - Open Setting

    static func openSetting(
        id: String,
        registry: SettingsRegistry = .shared,
        environment: SettingsEnvironment = .current
    ) {

        guard let entry =
            registry.entries.first(
                where: {
                    $0.id == id
                }
            )
        else {

            print(
                "❌ JAM SETTINGS TEST FAILED"
            )

            print(
                "No available setting with ID:",
                id
            )

            return
        }


        let destination =
            entry.resolvedDestination(
                environment: environment
            )


        guard let url =
            SettingsNavigationResolver.url(
                for: destination
            )
        else {

            print(
                "❌ JAM SETTINGS TEST FAILED"
            )

            print(
                "Invalid destination:",
                entry.displayName
            )

            return
        }


        print("")
        print("========== JAM SETTINGS TEST ==========")

        print("Setting:", entry.displayName)

        print(
            "Hierarchy:",
            entry.hierarchy.joined(
                separator: " → "
            )
        )

        print("Destination:", destination)

        print("URL:", url.absoluteString)

        print("Opening in 2 seconds...")

        print("=======================================")
        print("")


        NSWorkspace.shared.open(url)
    }
}

#endif
