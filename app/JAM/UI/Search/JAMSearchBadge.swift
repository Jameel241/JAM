import SwiftUI

struct JAMSearchBadge: View  {

    var body: some View {

        Text("JAM")
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(width: 54, height: 44)
            .background {

                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.08),
                                Color.white.opacity(0.03)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

            }
            .overlay {

                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(
                        Color.white.opacity(0.12),
                        lineWidth: 0.8
                    )

            }

    }

}

#Preview {
    JAMSearchBadge()
        .padding()
        .background(.black)
}
