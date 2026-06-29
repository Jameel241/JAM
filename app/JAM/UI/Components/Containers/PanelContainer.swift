import SwiftUI

struct PanelContainer<Content: View>: View {

    @ViewBuilder
    var content: Content

    var body: some View {

        content
            .padding(52)
            .background(JAMMaterials.panel)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: JAMRadius.floating,
                    style: .continuous
                )
            )
            .overlay {

                RoundedRectangle(
                    cornerRadius: JAMRadius.floating,
                    style: .continuous
                )
                .strokeBorder(
                    Color.white.opacity(0.08),
                    lineWidth: 0.5
                )

            }
            .shadow(
                color: .black.opacity(0.18),
                radius: JAMShadows.panelShadow,
                y: JAMShadows.panelY
            )
    }
}
