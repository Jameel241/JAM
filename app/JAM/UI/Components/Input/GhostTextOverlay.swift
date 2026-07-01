import SwiftUI

struct GhostTextOverlay: View {

    let typedText: String
    let suggestion: Suggestion?

    var body: some View {

        if let suggestion {

            let ghost = ghostText(from: suggestion)

            HStack(spacing: 0) {

                Text(typedText)
                    .foregroundStyle(.green)

                Text(ghost)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(.red)

                Spacer()

            }

        }

    }

    private func ghostText(from suggestion: Suggestion) -> String {

        guard suggestion.completion.hasPrefix(typedText) else {
            return ""
        }

        return String(
            suggestion.completion.dropFirst(typedText.count)
        )

    }

}
