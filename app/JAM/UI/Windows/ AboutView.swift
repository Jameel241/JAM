import SwiftUI
import AppKit

struct AboutView: View {
    @State
    private var showingUpdateAlert = false
    var body: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "sparkles")
                .font(.system(size: 64))
                .symbolVariant(.fill)

            VStack(spacing: 6) {

                Text("JAM")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Native Assistant for macOS")
                    .foregroundStyle(.secondary)

            }

            Divider()
                .frame(width: 300)

            Grid(alignment: .leading,
                 horizontalSpacing: 24,
                 verticalSpacing: 12) {

                GridRow {

                    Text("Version")
                        .foregroundStyle(.secondary)

                    Text("0.1.0")

                }

                GridRow {

                    Text("Build")
                        .foregroundStyle(.secondary)

                    Text("1")

                }

                GridRow {

                    Text("Developer")
                        .foregroundStyle(.secondary)

                    Text("Jameel Iqbal")

                }

            }

            HStack {

                Button("GitHub") {

                    if let url = URL(string: "https://github.com/Jameel241/JAM") {
                        NSWorkspace.shared.open(url)
                    }

                }

                Button("Website") {

                    if let url = URL(string: "https://github.com/Jameel241/JAM") {
                        NSWorkspace.shared.open(url)
                    }

                }
                Button("Check for Updates") {

                    showingUpdateAlert = true

                }

            }

            Spacer()

        }
        .alert(
            "JAM is up to date",
            isPresented: $showingUpdateAlert
        ) {

            Button("OK", role: .cancel) { }

        } message: {

            Text("You're running the latest version of JAM (0.1.0).")

        }
        .padding(40)

    }

}
