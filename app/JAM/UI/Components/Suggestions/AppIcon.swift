import SwiftUI
import AppKit

struct AppIcon: View {

    let url: URL?

    var body: some View {

        Group {

            if let url {

                Image(
                    nsImage: NSWorkspace.shared.icon(
                        forFile: url.path
                    )
                )
                .resizable()
                .scaledToFit()

            } else {

                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)

            }

        }
        .frame(width: 42, height: 42)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
        )

    }

}
