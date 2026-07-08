import SwiftUI
import AppKit

struct SuggestionList: View {

    @Environment(\.colorScheme)
    private var colorScheme

    let suggestions: [Suggestion]

    @State private var isScrollIndicatorVisible = false
    @State private var scrollIndicatorHideTask: DispatchWorkItem?

    @Binding var selectedIndex: Int
    @Binding var visibleStartIndex: Int
    @Binding var navigationSource: NavigationSource

    let onOpenSuggestion: (Int) -> Void

    @State private var trackpadOffset: CGFloat = 0
    @State private var mouseAccumulator: CGFloat = 0

    private let rowHeight: CGFloat = 72
    private let rowSpacing: CGFloat = 6
    private let visibleRowCount = 4

    private var rowStep: CGFloat {
        rowHeight + rowSpacing
    }

    private var maximumStartIndex: Int {
        max(
            0,
            suggestions.count - visibleRowCount
        )
    }

    // MARK: - Scroll Indicator Values

    private var scrollProgress: CGFloat {

        guard maximumStartIndex > 0 else {
            return 0
        }

        return CGFloat(visibleStartIndex)
            / CGFloat(maximumStartIndex)
    }

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .top) {

                // MARK: - Scroll Event Monitor

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

                // MARK: - Moving Content Layer

                ZStack(alignment: .top) {

                    // MARK: Highlight

                    RoundedRectangle(
                        cornerRadius: 14,
                        style: .continuous
                    )
                    .fill(
                        colorScheme == .dark
                            ? Color.white.opacity(0.17)
                            : Color.black.opacity(0.12)
                    )
                    .overlay {

                        RoundedRectangle(
                            cornerRadius: 14,
                            style: .continuous
                        )
                        .stroke(
                            colorScheme == .dark
                                ? Color.white.opacity(0.10)
                                : Color.black.opacity(0.10),
                            lineWidth: 1
                        )
                    }
                    .frame(height: rowHeight)
                    .padding(.horizontal, 12)
                    .offset(
                        y:
                            10
                            +
                            CGFloat(selectedIndex)
                            * rowStep
                    )
                    .allowsHitTesting(false)

                    // MARK: Suggestions

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
                            .contentShape(
                                RoundedRectangle(
                                    cornerRadius: 14
                                )
                            )
                            .onTapGesture(count: 2) {

                                navigationSource = .click

                                onOpenSuggestion(index)
                            }
                            .simultaneousGesture(

                                TapGesture(count: 1)
                                    .onEnded {

                                        navigationSource = .click

                                        var transaction =
                                            Transaction()

                                        transaction.disablesAnimations = true

                                        withTransaction(transaction) {

                                            selectedIndex = index
                                        }
                                    }
                            )
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
                .offset(
                    y:
                        -CGFloat(visibleStartIndex)
                        * rowStep
                        +
                        trackpadOffset
                )

                // MARK: - Scroll Indicator

                if suggestions.count > visibleRowCount {

                    let verticalPadding: CGFloat = 10

                    let trackHeight =
                        geometry.size.height
                        -
                        (verticalPadding * 2)

                    let viewportRatio =
                        CGFloat(visibleRowCount)
                        /
                        CGFloat(suggestions.count)

                    let thumbHeight = max(
                        32,
                        trackHeight * viewportRatio
                    )

                    let maximumThumbOffset = max(
                        0,
                        trackHeight - thumbHeight
                    )

                    let thumbOffset =
                        min(
                            max(
                                scrollProgress
                                * maximumThumbOffset,
                                0
                            ),
                            maximumThumbOffset
                        )

                    Capsule()
                        .fill(
                            colorScheme == .dark
                                ? Color.white.opacity(0.34)
                                : Color.black.opacity(0.28)
                        )
                        .frame(
                            width: 3,
                            height: thumbHeight
                        )
                        .position(
                            x: geometry.size.width - 8,
                            y:
                                verticalPadding
                                +
                                (thumbHeight / 2)
                                +
                                thumbOffset
                        )
                        .opacity(
                            isScrollIndicatorVisible
                                ? 1
                                : 0
                        )
                        .animation(
                            .easeOut(duration: 0.14),
                            value: isScrollIndicatorVisible
                        )
                        .animation(
                            .smooth(duration: 0.18),
                            value: visibleStartIndex
                        )
                        .allowsHitTesting(false)
                }
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
        .background {

            ZStack {

                Color.black.opacity(
                    colorScheme == .dark
                        ? 0.05
                        : 0.10
                )

                Rectangle()
                    .fill(.ultraThinMaterial)

                if colorScheme == .light {

                    Color.black.opacity(0.045)
                }
            }
        }
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            )
        )
        .onChange(of: visibleStartIndex) { _, _ in

            showScrollIndicator()

            if navigationSource == .keyboard {

                trackpadOffset = 0
                mouseAccumulator = 0
            }
        }
    }

    // MARK: - Scroll Handling

    private func handleScroll(
        _ deltaY: CGFloat,
        isPrecise: Bool,
        phase: NSEvent.Phase
    ) {

        navigationSource = .scroll

        showScrollIndicator()

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

        if visibleStartIndex == 0 &&
            deltaY > 0 {

            trackpadOffset = 0
            return
        }

        if visibleStartIndex == maximumStartIndex &&
            deltaY < 0 {

            trackpadOffset = 0
            return
        }

        trackpadOffset += deltaY

        while trackpadOffset <= -rowStep {

            guard visibleStartIndex <
                    maximumStartIndex
            else {

                trackpadOffset = 0
                return
            }

            visibleStartIndex += 1

            trackpadOffset += rowStep
        }

        while trackpadOffset >= rowStep {

            guard visibleStartIndex > 0
            else {

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

    // MARK: - Trackpad Settling

    private func settleTrackpad() {

        let threshold =
            rowStep * 0.50

        var targetStartIndex =
            visibleStartIndex

        if trackpadOffset <= -threshold {

            targetStartIndex = min(
                visibleStartIndex + 1,
                maximumStartIndex
            )

        } else if trackpadOffset >= threshold {

            targetStartIndex = max(
                visibleStartIndex - 1,
                0
            )
        }

        withAnimation(
            .interactiveSpring(
                response: 0.32,
                dampingFraction: 0.98,
                blendDuration: 0.12
            )
        ) {

            visibleStartIndex =
                targetStartIndex

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

        mouseAccumulator += deltaY

        let threshold: CGFloat = 5

        while mouseAccumulator <= -threshold {

            guard visibleStartIndex <
                    maximumStartIndex
            else {

                mouseAccumulator = 0
                return
            }

            visibleStartIndex += 1

            mouseAccumulator += threshold
        }

        while mouseAccumulator >= threshold {

            guard visibleStartIndex > 0
            else {

                mouseAccumulator = 0
                return
            }

            visibleStartIndex -= 1

            mouseAccumulator -= threshold
        }
    }

    // MARK: - Scroll Indicator Visibility

    private func showScrollIndicator() {

        scrollIndicatorHideTask?.cancel()

        if !isScrollIndicatorVisible {

            withAnimation(
                .easeOut(duration: 0.12)
            ) {

                isScrollIndicatorVisible = true
            }
        }

        let task = DispatchWorkItem {

            withAnimation(
                .easeOut(duration: 0.30)
            ) {

                isScrollIndicatorVisible = false
            }
        }

        scrollIndicatorHideTask = task

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.8,
            execute: task
        )
    }
}
