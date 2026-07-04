import SwiftUI

struct SuggestionList: View {

    let suggestions: [Suggestion]
    let visibleStartIndex: Int
    let highlightSlot: Int

    private let rowHeight: CGFloat = 72
    private let rowSpacing: CGFloat = 6
    private let visibleRowCount = 4

    private var rowStep: CGFloat {
        rowHeight + rowSpacing
    }

    private let navigationAnimation =
        Animation.interactiveSpring(
            response: 0.30,
            dampingFraction: 0.90,
            blendDuration: 0.15
        )

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .top) {

                // MARK: - Moving Suggestions

                VStack(spacing: rowSpacing) {

                    ForEach(
                        suggestions.indices,
                        id: \.self
                    ) { index in

                        SuggestionRow(
                            suggestion: suggestions[index],
                            isSelected: false
                        )
                        .frame(height: rowHeight)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .offset(
                    y:
                        -CGFloat(visibleStartIndex)
                        * rowStep
                )
                .animation(
                    navigationAnimation,
                    value: visibleStartIndex
                )

                // MARK: - Highlight

                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        Color.white.opacity(0.17)
                    )
                    .overlay {

                        RoundedRectangle(
                            cornerRadius: 14
                        )
                        .stroke(
                            Color.white.opacity(0.10),
                            lineWidth: 1
                        )
                    }
                    .frame(height: rowHeight)
                    .padding(.horizontal, 12)
                    .offset(
                        y:
                            10
                            +
                            CGFloat(highlightSlot)
                            * rowStep
                    )
                    .animation(
                        navigationAnimation,
                        value: highlightSlot
                    )
                    .allowsHitTesting(false)
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .top
            )
            .clipped()
        }
        .frame(
            height:
                CGFloat(visibleRowCount)
                * rowHeight
                +
                CGFloat(visibleRowCount - 1)
                * rowSpacing
                +
                20
        )
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }
}
