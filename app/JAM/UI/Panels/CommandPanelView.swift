import SwiftUI
import AppKit

struct CommandPanelView: View {

    @State private var commandText = ""
    @State private var suggestions: [Suggestion] = []
    @State private var selectedIndex = 0

    private let suggestionEngine = SuggestionEngine()

    private let parser = CommandParser()
    private let intentResolver = IntentResolver()
    private let actionExecutor = ActionExecutor()

    var body: some View {

        PanelContainer {

            VStack(alignment: .leading, spacing: JAMSpacing.lg) {

                Text(greeting)
                    .font(JAMTypography.title)

                Text("What would you like to do?")
                    .font(JAMTypography.body)
                    .foregroundStyle(JAMColors.secondaryText)

                JAMCommandField(

                    text: $commandText,

                    onSubmit: {

                        if suggestions.indices.contains(selectedIndex),
                           let url = suggestions[selectedIndex].url {

                            NSWorkspace.shared.open(url)
                            return
                        }

                        let parsed = parser.parse(commandText)

                        if let action = intentResolver.resolve(parsed) {
                            actionExecutor.execute(action)
                        }

                    },

                    onUpArrow: {

                        guard !suggestions.isEmpty else { return }
                        selectedIndex = max(0, selectedIndex - 1)

                    },

                    onDownArrow: {

                        guard !suggestions.isEmpty else { return }
                        selectedIndex = min(
                            suggestions.count - 1,
                            selectedIndex + 1
                        )

                    },

                    onTab: {

                        guard suggestions.indices.contains(selectedIndex) else {
                            return
                        }

                        commandText = suggestions[selectedIndex]
                            .displayText
                            .lowercased()

                    },

                    onEscape: {

                        commandText = ""
                        suggestions.removeAll()
                        selectedIndex = 0

                    }

                )
                .onChange(of: commandText) { _, newValue in

                    print("Typed:", newValue)

                    let results = suggestionEngine.suggestions(for: newValue)

                    print("Results:", results.count)

                    suggestions = results

                    print("State:", suggestions.count)

                    selectedIndex = 0

                }

                if !suggestions.isEmpty {

                    SuggestionList(
                        suggestions: suggestions,
                        selectedIndex: selectedIndex
                    )

                }

            }
            .frame(
                minWidth: 620,
                idealWidth: 720,
                maxWidth: 860
            )

        }

    }

        }



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



#Preview {
    CommandPanelView()
}
