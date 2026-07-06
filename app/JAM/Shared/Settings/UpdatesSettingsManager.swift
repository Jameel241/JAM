import Foundation
import Combine

@MainActor
final class UpdatesSettingsManager: ObservableObject {

    static let shared = UpdatesSettingsManager()

    @Published var automaticallyCheckForUpdates: Bool {
        didSet {
            UserDefaults.standard.set(
                automaticallyCheckForUpdates,
                forKey: "AutomaticallyCheckForUpdates"
            )
        }
    }

    @Published var includeBetaReleases: Bool {
        didSet {
            UserDefaults.standard.set(
                includeBetaReleases,
                forKey: "IncludeBetaReleases"
            )
        }
    }
    @Published var lastChecked: Date? {
        didSet {
            UserDefaults.standard.set(
                lastChecked,
                forKey: "LastUpdateCheck"
            )
        }
    }

    private init() {

        automaticallyCheckForUpdates =
            UserDefaults.standard.object(
                forKey: "AutomaticallyCheckForUpdates"
            ) as? Bool ?? true

        includeBetaReleases =
            UserDefaults.standard.object(
                forKey: "IncludeBetaReleases"
            ) as? Bool ?? false

    }

}
