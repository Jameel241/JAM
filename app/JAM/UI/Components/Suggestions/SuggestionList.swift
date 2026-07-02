import SwiftUI

struct SuggestionList: View {

    let suggestions: [Suggestion]
    let selectedIndex: Int

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            LazyVStack(spacing: 8) {

                ForEach(suggestions.indices, id: \.self) { index in

                    SuggestionRow(
                        suggestion: suggestions[index],
                        isSelected: index == selectedIndex
                    )

                }

            }
            .padding(8)

        }
        .frame(maxHeight: 320)
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )

    }

}
