import SwiftUI

struct SuggestionRow: View {

    let suggestion: Suggestion
    let isSelected: Bool

    var onHover: (() -> Void)?
    var onClick: (() -> Void)?

    var body: some View {

        HStack(spacing: 16) {

            suggestionIcon

            VStack(
                alignment: .leading,
                spacing: 2
            ) {

                Text(suggestion.displayText)
                    .foregroundStyle(.white)
                    .font(.headline)

                Text(suggestion.subtitle)
                    .foregroundStyle(.gray)
                    .font(.caption)

            }

            Spacer()

        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
        .onHover { hovering in

            if hovering {
                onHover?()
            }

        }
        .onTapGesture {

            onClick?()

        }

    }

    @ViewBuilder
    private var suggestionIcon: some View {

        switch suggestion.kind {

        case .application:

            AppIcon(url: suggestion.url)

        case .folder:

            Image(systemName: "folder.fill")
                .font(.title2)
                .frame(width: 32, height: 32)

        case .file:

            Image(systemName: "doc.fill")
                .font(.title2)
                .frame(width: 32, height: 32)

        case .command:

            Image(systemName: "terminal.fill")
                .font(.title2)
                .frame(width: 32, height: 32)
            
        case .setting:

            Image(systemName: "gearshape.fill")
                .font(.title2)
                .frame(width: 32, height: 32)

        }

    }

}
