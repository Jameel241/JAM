import SwiftUI

struct JAMResultsContainer<Content: View>: View {

    let isVisible: Bool

    @ViewBuilder
    var content: Content

    var body: some View {

        VStack(spacing: 0) {

            if isVisible {

                Divider()
                    .overlay(Color.white.opacity(0.08))

                content
                    .padding(.vertical, 8)
                    .transition(.opacity)

            }

        }

    }

}
