import SwiftUI

struct SuggestionRow: View {

    @Environment(\.colorScheme)
    private var colorScheme

    let suggestion: Suggestion
    let isSelected: Bool

    var onHover: (() -> Void)?
    var onClick: (() -> Void)?

    private var primaryColor: Color {
        colorScheme == .dark
            ? .white
            : Color.black.opacity(0.78)
    }

    private var secondaryColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.48)
            : Color.black.opacity(0.48)
    }

    private var iconColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.82)
            : Color.black.opacity(0.68)
    }

    var body: some View {

        HStack(spacing: 16) {

            suggestionIcon

            VStack(
                alignment: .leading,
                spacing: 2
            ) {

                Text(suggestion.displayText)
                    .foregroundStyle(primaryColor)
                    .font(.headline)

                Text(suggestion.subtitle)
                    .foregroundStyle(secondaryColor)
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
                .foregroundStyle(iconColor)
                .frame(width: 32, height: 32)

        case .file:

            Image(systemName: "doc.fill")
                .font(.title2)
                .foregroundStyle(iconColor)
                .frame(width: 32, height: 32)

        case .command:

            Image(systemName: "terminal.fill")
                .font(.title2)
                .foregroundStyle(iconColor)
                .frame(width: 32, height: 32)

        case .setting:

            Image(systemName: "gearshape.fill")
                .font(.title2)
                .foregroundStyle(iconColor)
                .frame(width: 32, height: 32)

        }

    }

}
