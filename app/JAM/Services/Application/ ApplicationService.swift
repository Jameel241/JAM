import AppKit

final class ApplicationService {

    func openApplication(named name: String) {

        guard let url = ApplicationRegistry.shared.url(for: name) else {

            print("Application '\(name)' not found.")
            return

        }

        let configuration = NSWorkspace.OpenConfiguration()

        NSWorkspace.shared.openApplication(
            at: url,
            configuration: configuration
        ) { _, error in

            if let error {
                print("Failed to open \(name): \(error.localizedDescription)")
            } else {
                print("Opened \(name)")
            }

        }

    }

}
