import SwiftUI

enum JAMMetrics {

    // Search

    static let searchBarHeight: CGFloat = 68
    static let searchCornerRadius: CGFloat = 34

    // Greeting

    static let greetingSpacing: CGFloat = 28
    static let compactGreetingSpacing: CGFloat = 8

    // Results

    static let resultRowHeight: CGFloat = 72
    static let maxVisibleResults = 6

    static let resultsPadding: CGFloat = 16

    static var maxResultsHeight: CGFloat {
        CGFloat(maxVisibleResults) * resultRowHeight
    }

    // Panel

    static let panelPadding: CGFloat = 40
    // Window

    static let collapsedWindowHeight: CGFloat = 170

    static func expandedWindowHeight(
        resultCount: Int
    ) -> CGFloat {

        let visibleRows = min(
            resultCount,
            maxVisibleResults
        )

        return collapsedWindowHeight
            + CGFloat(visibleRows) * resultRowHeight

    }

}
