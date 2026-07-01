import Foundation

protocol SuggestionProvider {

    func suggestions(for input: String) -> [Suggestion]

}
