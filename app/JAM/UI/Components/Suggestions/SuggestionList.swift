import SwiftUI
import AppKit

struct SuggestionList: View {

    let suggestions: [Suggestion]

    @Binding var visibleStartIndex: Int

    let highlightSlot: Int

    @State private var trackpadOffset: CGFloat = 0
    @State private var lastMouseScrollTime: TimeInterval = 0

    private let rowHeight: CGFloat = 72
    private let rowSpacing: CGFloat = 6
    private let visibleRowCount = 4

    private var rowStep: CGFloat {
        rowHeight + rowSpacing
    }

    private var maximumStartIndex: Int {
        max(0, suggestions.count - visibleRowCount)
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

                JAMScrollEventMonitor {
                    deltaY,
                    isPrecise,
                    phase in

                    handleScroll(
                        deltaY,
                        isPrecise: isPrecise,
                        phase: phase
                    )
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )

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
                        -CGFloat(visibleStartIndex) * rowStep
                        +
                        trackpadOffset
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
                            CGFloat(highlightSlot) * rowStep
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
                CGFloat(visibleRowCount) * rowHeight
                +
                CGFloat(visibleRowCount - 1) * rowSpacing
                +
                20
        )
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }

    // MARK: - Scroll Handling

    private func handleScroll(
        _ deltaY: CGFloat,
        isPrecise: Bool,
        phase: NSEvent.Phase
    ) {

        if isPrecise {

            handleTrackpadScroll(
                deltaY,
                phase: phase
            )

        } else {

            handleMouseScroll(deltaY)
        }
    }

  

    // MARK: - Trackpad

    private func handleTrackpadScroll(
        _ deltaY: CGFloat,
        phase: NSEvent.Phase
    ) {

        // Hard stop at upper boundary
        if visibleStartIndex == 0 && deltaY > 0 {

            trackpadOffset = 0
            return
        }

        // Hard stop at lower boundary
        if visibleStartIndex == maximumStartIndex && deltaY < 0 {

            trackpadOffset = 0
            return
        }

        trackpadOffset += deltaY

        while trackpadOffset <= -rowStep {

            guard visibleStartIndex < maximumStartIndex else {

                trackpadOffset = 0
                return
            }

            visibleStartIndex += 1
            trackpadOffset += rowStep
        }

        while trackpadOffset >= rowStep {

            guard visibleStartIndex > 0 else {

                trackpadOffset = 0
                return
            }

            visibleStartIndex -= 1
            trackpadOffset -= rowStep
        }

        if phase == .ended ||
            phase == .cancelled {

            settleTrackpad()
        }
    }

    private func settleTrackpad() {

        let threshold = rowStep * 0.35

        if trackpadOffset <= -threshold {

            if visibleStartIndex < maximumStartIndex {

                visibleStartIndex += 1
            }

        } else if trackpadOffset >= threshold {

            if visibleStartIndex > 0 {

                visibleStartIndex -= 1
            }
        }

        withAnimation(
            .interactiveSpring(
                response: 0.28,
                dampingFraction: 0.92,
                blendDuration: 0.12
            )
        ) {

            trackpadOffset = 0
        }
    }


    // MARK: - Mouse Wheel

    private func handleMouseScroll(
        _ deltaY: CGFloat
    ) {

        guard deltaY != 0 else {
            return
        }

        let currentTime = ProcessInfo.processInfo.systemUptime

        let minimumInterval: TimeInterval = 0.055

        guard currentTime - lastMouseScrollTime >= minimumInterval else {
            return
        }

        lastMouseScrollTime = currentTime

        if deltaY < 0 {

            guard visibleStartIndex < maximumStartIndex else {
                return
            }

            visibleStartIndex += 1

        } else {

            guard visibleStartIndex > 0 else {
                return
            }

            visibleStartIndex -= 1
        }
    }
}
