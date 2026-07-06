import SwiftUI
import Combine

enum AppTheme: String, CaseIterable, Identifiable {

    case system
    case light
    case dark

    var id: String { rawValue }

}

@MainActor
final class AppearanceSettingsManager: ObservableObject {

    static let shared = AppearanceSettingsManager()

    @Published var selectedTheme: AppTheme {
        didSet {

            UserDefaults.standard.set(
                selectedTheme.rawValue,
                forKey: "selectedTheme"
            )

            WindowManager.shared.updateAppearance()

        }
    }

    @Published var animationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(
                animationsEnabled,
                forKey: "animationsEnabled"
            )
        }
    }

    @Published var glassEffectsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(
                glassEffectsEnabled,
                forKey: "glassEffectsEnabled"
            )
        }
    }

    @Published var blurBackgroundEnabled: Bool {
        didSet {
            UserDefaults.standard.set(
                blurBackgroundEnabled,
                forKey: "blurBackgroundEnabled"
            )
        }
    }

    private init() {

        selectedTheme =
            AppTheme(
                rawValue: UserDefaults.standard.string(
                    forKey: "selectedTheme"
                ) ?? "system"
            ) ?? .system

        animationsEnabled =
            UserDefaults.standard.object(forKey: "animationsEnabled") as? Bool ?? true

        glassEffectsEnabled =
            UserDefaults.standard.object(forKey: "glassEffectsEnabled") as? Bool ?? true

        blurBackgroundEnabled =
            UserDefaults.standard.object(forKey: "blurBackgroundEnabled") as? Bool ?? true

    }

}
