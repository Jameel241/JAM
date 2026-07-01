import SwiftUI

struct JAMSearchBar: View {

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

            Divider()
                .frame(height: 28)
                .overlay(Color.white.opacity(0.08))

            JAMSearchIcon()

            ZStack(alignment: .leading) {

                if text.isEmpty {

                    Text("Search apps, files, or commands...")
                        .foregroundStyle(JAMColors.secondaryText)
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
            .animation(JAMAnimation.search, value: text.isEmpty)
            .frame(maxWidth: .infinity)

            JAMShortcutBadge(
                isSearching: isSearching
            )

        }
        .padding(.horizontal, 18)
        .frame(height: 68)
        .background {

            RoundedRectangle(
                cornerRadius: 34,
                style: .continuous
            )
            .fill(JAMMaterials.commandField)

            RoundedRectangle(
                cornerRadius: 34,
                style: .continuous
            )
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.02)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: 34,
                style: .continuous
            )
            .strokeBorder(
                Color.white.opacity(0.12),
                lineWidth: 0.8
            )

        }
        .shadow(
            color: Color.purple.opacity(0.08),
            radius: 30,
            y: 18
        )

    }

}
