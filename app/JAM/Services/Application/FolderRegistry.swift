import Foundation
import Combine

@MainActor
final class FolderRegistry: ObservableObject {

    static let shared = FolderRegistry()

    @Published
    private(set) var entries: [FolderEntry] = []

    @Published
    private(set) var isIndexing = false

    @Published
    private(set) var lastIndexed: Date?

    private init() {

#if DEBUG
        print("📁 FolderRegistry initialized")
#endif

        Task {
            await rebuild()
        }

    }

    func rebuild() async {

        isIndexing = true
        entries.removeAll()

        let homeDirectory = URL(
            fileURLWithPath: NSHomeDirectory(),
            isDirectory: true
        )

        let folders: [URL] = [

            homeDirectory.appendingPathComponent("Desktop"),
            homeDirectory.appendingPathComponent("Documents"),
            homeDirectory.appendingPathComponent("Downloads"),
            homeDirectory.appendingPathComponent("Movies"),
            homeDirectory.appendingPathComponent("Music"),
            homeDirectory.appendingPathComponent("Pictures"),
            homeDirectory
                .appendingPathComponent("Desktop")
                .appendingPathComponent("Developer")

        ]

        var discoveredFolders: [FolderEntry] = []

        for folder in folders {

            guard FileManager.default.fileExists(
                atPath: folder.path
            ) else {
                continue
            }

            let displayName = folder.lastPathComponent

            discoveredFolders.append(
                FolderEntry(
                    id: folder,
                    displayName: displayName,
                    url: folder,
                    aliases: makeAliases(for: displayName)
                )
            )

        }

        entries = discoveredFolders

        lastIndexed = Date()
        isIndexing = false

#if DEBUG
        print("Loaded \(entries.count) folders.")
#endif

    }

    private func makeAliases(
        for name: String
    ) -> [String] {

        let lower = name.lowercased()

        var aliases = Set<String>()

        aliases.insert(lower)

        let words = lower
            .split(separator: " ")
            .map(String.init)

        aliases.formUnion(words)

        let acronym = words
            .compactMap(\.first)
            .map(String.init)
            .joined()

        if acronym.count > 1 {
            aliases.insert(acronym)
        }

        return aliases.sorted()

    }

}
