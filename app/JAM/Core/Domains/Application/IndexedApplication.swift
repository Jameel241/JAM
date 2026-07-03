import AppKit

struct IndexedApplication: Identifiable, Hashable {

    let id = UUID()

    let name: String

    let bundleIdentifier: String?

    let url: URL

    let icon: NSImage?

}
