import SwiftUI
import AppKit

enum NavigationSource {
    case keyboard
    case scroll
    case click
}

struct JAMSearchView: View {

    @State private var searchText = ""
    @State private var suggestions: [Suggestion] = []
   
    @State private var selectedIndex = 0
    @State private var visibleStartIndex = 0
    @State private var navigationSource: NavigationSource = .keyboard
    
    
    private let suggestionEngine = SuggestionEngine()

    private let visibleRowCount = 4

    private var isSearching: Bool {
        !searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
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
                            onSubmit: openSelectedSuggestion,
                            onUpArrow: moveSelectionUp,
                            onDownArrow: moveSelectionDown,
                            onTab: autocompleteSelection,
                            onEscape: clearSearch
                        )

                        if !suggestions.isEmpty {

                            Divider()
                                .overlay(
                                    Color.white.opacity(0.08)
                                )

                            SuggestionList(
                                suggestions: suggestions,
                                selectedIndex: $selectedIndex,
                                visibleStartIndex: $visibleStartIndex,
                                navigationSource: $navigationSource,
                                onOpenSuggestion: openSuggestion
                            )
                        }
                    }

                    Spacer()
                }
                .onChange(of: searchText) { _, value in

                    suggestions =
                        suggestionEngine.suggestions(
                            for: value
                        )

                    resetNavigation()
                }
            }
        }
    }

    // MARK: - Navigation

    private func moveSelectionDown() {

        guard !suggestions.isEmpty else {
            return
        }

        guard selectedIndex < suggestions.count - 1 else {
            return
        }

        navigationSource = .keyboard

        withAnimation(
            .interactiveSpring(
                response: 0.30,
                dampingFraction: 0.94,
                blendDuration: 0.12
            )
        ) {

            selectedIndex += 1

            if selectedIndex >=
                visibleStartIndex + visibleRowCount {

                visibleStartIndex =
                    selectedIndex - visibleRowCount + 1
            }
        }
    }

    private func moveSelectionUp() {

        guard !suggestions.isEmpty else {
            return
        }

        guard selectedIndex > 0 else {
            return
        }

        navigationSource = .keyboard

        withAnimation(
            .interactiveSpring(
                response: 0.30,
                dampingFraction: 0.94,
                blendDuration: 0.12
            )
        ) {

            selectedIndex -= 1

            if selectedIndex < visibleStartIndex {

                visibleStartIndex = selectedIndex
            }
        }
    }

    // MARK: - Actions

    private func openSelectedSuggestion() {

        openSuggestion(selectedIndex)
    }

    private func openSuggestion(
        _ index: Int
    ) {

        guard suggestions.indices.contains(index) else {
            return
        }

        let suggestion = suggestions[index]

        switch suggestion.execution {

        case .openURL(let url):

            NSWorkspace.shared.open(url)

        case .quitApplication(let applicationName):

            let action = QuitApplicationAction(
                applicationName: applicationName
            )

            ActionExecutor().execute(action)
            
        case .quitAllApplications:

            let action = QuitAllApplicationsAction()

            ActionExecutor().execute(action)
        case .hideAllApplications:

            let action = HideAllApplicationsAction()

            ActionExecutor().execute(action)
        case .none:

            return
        }

        clearSearch()

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.1
        ) {

            WindowManager.shared.hideCommandPanel()
        }
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

        resetNavigation()
    }

    private func resetNavigation() {

        selectedIndex = 0
        visibleStartIndex = 0
        navigationSource = .keyboard
    }
    // MARK: - Greeting

    private var greeting: String {

        let hour = Calendar.current.component(
            .hour,
            from: Date()
        )

        let preferredName =
            AppStateManager.shared.preferredName
                .trimmingCharacters(in: .whitespacesAndNewlines)

        let greetingPrefix: String

        switch hour {

        case 5..<12:
            greetingPrefix = "Good morning"

        case 12..<17:
            greetingPrefix = "Good afternoon"

        case 17..<22:
            greetingPrefix = "Good evening"

        default:
            greetingPrefix = "Good night"
        }

        if preferredName.isEmpty {
            return "\(greetingPrefix)."
        }

        return "\(greetingPrefix), \(preferredName)."
    }
}

#Preview {
    JAMSearchView()
}
