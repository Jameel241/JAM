import SwiftUI

struct JAMSearchBar: View {

    @Environment(\.colorScheme)
    private var colorScheme

    @Binding var text: String

    var onSubmit: () -> Void

    var onUpArrow: (() -> Void)?
    var onDownArrow: (() -> Void)?
    var onTab: (() -> Void)?
    var onEscape: (() -> Void)?

    private var isSearching: Bool {
        !text.isEmpty
    }

    var body: some View {

        HStack(spacing: 18) {

            JAMSearchBadge()

            Rectangle()
                .fill(
                    colorScheme == .dark
                        ? Color.white.opacity(0.12)
                        : Color.black.opacity(0.14)
                )
                .frame(width: 1, height: 30)

            JAMSearchIcon()

            ZStack(alignment: .leading) {

                if text.isEmpty {

                    Text("Search apps, files, or commands...")
                        .foregroundStyle(
                            colorScheme == .dark
                                ? Color.white.opacity(0.60)
                                : Color.black.opacity(0.58)
                        )
                        .font(JAMTypography.body)
                        .allowsHitTesting(false)
                        .transition(.opacity)
                }

                JAMNativeTextField(
                    text: $text,
                    onSubmit: onSubmit,
                    onUpArrow: onUpArrow,
                    onDownArrow: onDownArrow,
                    onTab: onTab,
                    onEscape: onEscape
                )
            }
            .frame(maxWidth: .infinity)

            JAMShortcutBadge()
        }
        .padding(.horizontal, 18)
        .frame(height: JAMMetrics.searchBarHeight)
    }
}
