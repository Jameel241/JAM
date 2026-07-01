import SwiftUI

struct JAMShortcutBadge: View {

    var isSearching: Bool

    var body: some View {

        Group {

            if isSearching {

                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))

            } else {

                HStack(spacing: 4) {

                    Image(systemName: "command")
                        .font(.system(size: 11, weight: .bold))

                    Text("K")
                        .font(.system(size: 12, weight: .semibold))

                }
                .foregroundStyle(.white.opacity(0.85))

            }

        }
        .frame(width: 36, height: 36)
        .background {

            Circle()
                .fill(.white.opacity(0.06))

        }
        .overlay {

            Circle()
                .strokeBorder(
                    .white.opacity(0.10),
                    lineWidth: 0.7
                )

        }
        .animation(.snappy(duration: 0.2), value: isSearching)

    }

}

#Preview {

    ZStack {

        Color.black

        VStack(spacing: 30) {

            JAMShortcutBadge(isSearching: false)

            JAMShortcutBadge(isSearching: true)

        }

    }

}
