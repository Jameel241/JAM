import AppKit

final class ApplicationService {

    func openApplication(named name: String) {

        guard let url = ApplicationRegistry.shared.url(for: name) else {

            print("Application '\(name)' not found.")
            return
        }

        let configuration = NSWorkspace.OpenConfiguration()

        NSWorkspace.shared.openApplication(
            at: url,
            configuration: configuration
        ) { _, error in

            if let error {

                print(
                    "Failed to open \(name): \(error.localizedDescription)"
                )

            } else {

                print("Opened \(name)")
            }
        }
    }

    func quitApplication(named name: String) {

        let normalizedName = name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        let runningApplications =
            NSWorkspace.shared.runningApplications

        guard let application =
                runningApplications.first(where: { application in

                    guard let localizedName =
                            application.localizedName?
                                .lowercased()
                    else {
                        return false
                    }

                    return localizedName == normalizedName

                }) else {

            print("Application '\(name)' is not running.")
            return
        }

        let didTerminate = application.terminate()

        if didTerminate {

            print("Requested termination of \(name)")

        } else {

            print("Failed to terminate \(name)")
        }
    }
    func quitAllApplications() {

        let runningApplications =
            NSWorkspace.shared.runningApplications

        let jamBundleIdentifier =
            Bundle.main.bundleIdentifier

        for application in runningApplications {

            // Never quit JAM itself
            if application.bundleIdentifier ==
                jamBundleIdentifier {
                continue
            }

            // Keep Finder running
            if application.bundleIdentifier ==
                "com.apple.finder" {
                continue
            }
            
#if DEBUG

// Keep Xcode running while JAM is launched from Xcode
if application.bundleIdentifier == "com.apple.dt.Xcode" {
    continue
}

#endif

            // Ignore background processes and agents
            guard application.activationPolicy == .regular else {
                continue
            }

            let applicationName =
                application.localizedName
                ?? "Unknown Application"

            let didTerminate =
                application.terminate()

            if didTerminate {

                print(
                    "Requested termination of \(applicationName)"
                )

            } else {

                print(
                    "Failed to terminate \(applicationName)"
                )
            }
        }
    }
}
