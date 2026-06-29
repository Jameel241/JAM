import SwiftUI

enum JAMMotion {

    static let quick = Animation.easeOut(duration: 0.15)

    static let standard = Animation.easeOut(duration: 0.22)

    static let panel = Animation.spring(
        response: 0.45,
        dampingFraction: 0.86
    )
}
