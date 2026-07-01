import SwiftUI

struct PanelContainer<Content: View>: View {

    @ViewBuilder
    var content: Content

    var body: some View {

        content
            .padding(JAMSpacing.xxl)
            .background {

                RoundedRectangle(
                    cornerRadius: JAMRadius.panel,
                    style: .continuous
                )
                .fill(JAMMaterials.panel)

                RoundedRectangle(
                    cornerRadius: JAMRadius.panel,
                    style: .continuous
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.06),
                            Color.white.opacity(0.015)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            }
            .overlay {

                RoundedRectangle(
                    cornerRadius: JAMRadius.panel,
                    style: .continuous
                )
                .strokeBorder(
                    Color.white.opacity(0.10),
                    lineWidth: 0.6
                )

            }
            .shadow(
                color: .black.opacity(JAMShadows.panelOpacity),
                radius: JAMShadows.panelRadius,
                x: 0,
                y: JAMShadows.panelY
            )

    }

}
