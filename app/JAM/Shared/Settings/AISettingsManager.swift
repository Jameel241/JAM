import SwiftUI
import Combine

@MainActor
final class AISettingsManager: ObservableObject {

    static let shared = AISettingsManager()

    private enum KeychainAccounts {
        static let apiKey = "ai-api-key"
    }

    @Published var provider: AIProvider = .openAI

    @Published var streamingEnabled = true

    @Published var suggestionsEnabled = true

    @Published var apiKey = "" {

        didSet {

            updateConnectionState()

            guard !isLoadingAPIKey else {
                return
            }

            persistAPIKey()
        }
    }

    @Published var revealAPIKey = false

    @Published var connectionState: AIConnectionState =
        .notConfigured

    private var isLoadingAPIKey = false

    private init() {

        loadAPIKey()
    }

    private func loadAPIKey() {

        isLoadingAPIKey = true

        defer {
            isLoadingAPIKey = false
        }

        do {

            apiKey =
                try KeychainManager.shared.load(
                    for: KeychainAccounts.apiKey
                ) ?? ""

        } catch {

            apiKey = ""

            #if DEBUG
            print(
                "Failed to load API key from Keychain:",
                error.localizedDescription
            )
            #endif
        }
    }

    private func persistAPIKey() {

        do {

            if apiKey.isEmpty {

                try KeychainManager.shared.delete(
                    for: KeychainAccounts.apiKey
                )

            } else {

                try KeychainManager.shared.save(
                    apiKey,
                    for: KeychainAccounts.apiKey
                )
            }

        } catch {

            #if DEBUG
            print(
                "Failed to update API key in Keychain:",
                error.localizedDescription
            )
            #endif
        }
    }

    private func updateConnectionState() {

        if apiKey.isEmpty {
            connectionState = .notConfigured
        } else {
            connectionState = .notTested
        }
    }
}
