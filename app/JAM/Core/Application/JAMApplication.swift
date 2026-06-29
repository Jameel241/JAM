import Foundation

/// The central coordinator of JAM.
///
/// Every part of the application starts here.
/// This object is responsible for initializing
/// the application's core systems.
final class JAMApplication {

    static let shared = JAMApplication()

    private init() {}

    func start() {
        print(" JAM is starting...")
    }
}
