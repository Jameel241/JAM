import SwiftUI

struct SuggestionList: View {

    let suggestions: [Suggestion]
    let selectedIndex: Int

    var body: some View {

        VStack(spacing: 8) {

            ForEach(suggestions.indices, id: \.self) { index in

                SuggestionRow(
                    suggestion: suggestions[index],
                    isSelected: index == selectedIndex
                )

            }

        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )

    }

}
