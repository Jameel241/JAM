import Foundation

enum AIProvider: String, CaseIterable, Identifiable {

    case openAI = "OpenAI"
    case anthropic = "Anthropic"
    case gemini = "Google Gemini"
    case ollama = "Ollama (Local)"

    var id: String { rawValue }

}
