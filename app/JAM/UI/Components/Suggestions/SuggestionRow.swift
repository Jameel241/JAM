import SwiftUI

struct SuggestionRow: View {

    let suggestion: Suggestion
    let isSelected: Bool

    var body: some View {

        HStack(spacing: 16) {

            AppIcon(url: suggestion.url)

            VStack(alignment: .leading) {

                Text(suggestion.displayText)
                    .foregroundStyle(.white)
                    .font(.headline)

                Text(suggestion.subtitle)
                    .foregroundStyle(.gray)
                    .font(.caption)

            }

            Spacer()

        }
        .padding()
        .background(
            isSelected
                ? Color.white.opacity(0.10)
                : Color.clear
        )
    }
}
