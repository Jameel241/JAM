import Foundation

struct Suggestion: Identifiable, Equatable {

    let id = UUID()
    
    let kind: SuggestionKind

    let displayText: String

    let completion: String

    let confidence: Double

    let url: URL?

    let subtitle: String

}
