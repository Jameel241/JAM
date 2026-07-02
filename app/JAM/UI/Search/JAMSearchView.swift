import SwiftUI
import AppKit

struct JAMSearchView: View {

    @State private var searchText = ""
    @State private var suggestions: [Suggestion] = []
    @State private var selectedIndex = 0

    private let suggestionEngine = SuggestionEngine()

    private var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {

        PanelContainer {
            
            VStack(spacing: 20) {
                
                JAMGreetingCard(
                    greeting: greeting
                )
                .opacity(isSearching ? 0 : 1)
                
                JAMSearchSurface(text: $searchText) {
                    
                    VStack(spacing: 0) {
                        
                        JAMSearchBar(
                            text: $searchText,
                            onSubmit: launchSelectedApplication,
                            onUpArrow: moveSelectionUp,
                            onDownArrow: moveSelectionDown,
                            onTab: autocompleteSelection,
                            onEscape: clearSearch
                        )
                        
                        if !suggestions.isEmpty {
                            
                            Divider()
                                .overlay(Color.white.opacity(0.08))
                            
                            SuggestionList(
                                suggestions: suggestions,
                                selectedIndex: selectedIndex
                            )
                        }
                        
                    }
                 
                    Spacer()
                }
               
                
                .onChange(of: searchText) { _, value in
                    
                    print("Typed:", value)
                    
                    suggestions = suggestionEngine.suggestions(for: value)
                    
                    print("Suggestions:", suggestions.map(\.displayText))
                    
                    selectedIndex = 0
                    
                }
                
            }
        }
    }

    // MARK: - Actions

    private func launchSelectedApplication() {

        guard suggestions.indices.contains(selectedIndex),
              let url = suggestions[selectedIndex].url else {
            return
        }

        NSWorkspace.shared.open(url)

        clearSearch()

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.1
        ) {

            WindowManager.shared.hideCommandPanel()

        }

    }

    private func moveSelectionUp() {

        guard !suggestions.isEmpty else { return }

        selectedIndex = max(
            0,
            selectedIndex - 1
        )

    }

    private func moveSelectionDown() {

        guard !suggestions.isEmpty else { return }

        selectedIndex = min(
            suggestions.count - 1,
            selectedIndex + 1
        )

    }

    private func autocompleteSelection() {

        guard suggestions.indices.contains(selectedIndex) else {
            return
        }

        searchText = suggestions[selectedIndex]
            .displayText
            .lowercased()

    }

    private func clearSearch() {

        searchText = ""
        suggestions.removeAll()
        selectedIndex = 0

    }

    // MARK: - Greeting

    private var greeting: String {

        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {

        case 5..<12:
            return "Good morning, Jameel."

        case 12..<17:
            return "Good afternoon, Jameel."

        case 17..<22:
            return "Good evening, Jameel."

        default:
            return "Good night, Jameel."

        }

    }

}

#Preview {
    JAMSearchView()
}
