import SwiftUI
import Combine


@MainActor
final class AISettingsManager: ObservableObject {

    static let shared = AISettingsManager()

    @Published var provider: AIProvider = .openAI

    @Published var streamingEnabled = true

    @Published var suggestionsEnabled = true

    @Published var apiKey = "" {

        didSet {

            if apiKey.isEmpty {

                connectionState = .notConfigured

            } else {

                connectionState = .notTested

            }

        }

    }
    
    @Published var revealAPIKey = false
    
    @Published var connectionState: AIConnectionState = .notConfigured

   


    private init() { }

}
