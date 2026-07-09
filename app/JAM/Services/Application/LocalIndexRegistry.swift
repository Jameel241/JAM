import Foundation
import Combine

@MainActor
final class LocalIndexRegistry: ObservableObject {

    static let shared = LocalIndexRegistry()

    @Published
    private(set) var entries: [IndexedItem] = []

    @Published
    private(set) var isIndexing = false

    @Published
    private(set) var lastIndexed: Date?

    @Published
    private(set) var lastError: Error?
    
    private var rebuildRequested = false

    private init() {

        print("🔎 LocalIndexRegistry initialized")

        Task {
            await rebuild()
        }

    }

    func rebuild() async {

        if isIndexing {

            rebuildRequested = true
            return
        }

        repeat {

            rebuildRequested = false

            isIndexing = true
            lastError = nil

            do {

                let discoveredItems = try await Task.detached(
                    priority: .utility
                ) {

                    try Self.buildIndex()

                }.value

                entries = discoveredItems
                lastIndexed = Date()

                print(
                    "Loaded \(entries.count) local files and folders."
                )

            } catch {

                lastError = error

                print(
                    "Local indexing failed:",
                    error.localizedDescription
                )

            }

            isIndexing = false

        } while rebuildRequested
    }

    nonisolated
    private static func buildIndex() throws -> [IndexedItem] {

        let fileManager = FileManager.default

        let homeDirectory =
            fileManager.homeDirectoryForCurrentUser

        let searchLocations: [URL] = [

            homeDirectory.appendingPathComponent("Desktop"),
            homeDirectory.appendingPathComponent("Documents"),
            homeDirectory.appendingPathComponent("Downloads"),
            homeDirectory.appendingPathComponent("Movies"),
            homeDirectory.appendingPathComponent("Music"),
            homeDirectory.appendingPathComponent("Pictures")

        ]

        var discoveredItems: [IndexedItem] = []

        for location in searchLocations {

            guard fileManager.fileExists(
                atPath: location.path
            ) else {
                continue
            }

            Self.scan(
                location,
                fileManager: fileManager,
                into: &discoveredItems
            )

        }

        return Self.removeDuplicates(
            from: discoveredItems
        )

    }

    nonisolated
    private static func scan(
        _ location: URL,
        fileManager: FileManager,
        into discoveredItems: inout [IndexedItem]
    ) {

        let resourceKeys: Set<URLResourceKey> = [
            .isDirectoryKey,
            .isRegularFileKey,
            .isHiddenKey
        ]

        guard let enumerator = fileManager.enumerator(
            at: location,
            includingPropertiesForKeys: Array(resourceKeys),
            options: [
                .skipsHiddenFiles,
                .skipsPackageDescendants
            ]
        ) else {
            return
        }

        for case let url as URL in enumerator {

            do {

                let resourceValues =
                    try url.resourceValues(
                        forKeys: resourceKeys
                    )

                guard resourceValues.isHidden != true else {
                    continue
                }

                let kind: IndexedItemKind

                if resourceValues.isDirectory == true {

                    kind = .folder

                } else if resourceValues.isRegularFile == true {

                    kind = .file

                } else {

                    continue

                }

                let displayName = url.lastPathComponent

                discoveredItems.append(
                    IndexedItem(
                        id: url,
                        kind: kind,
                        displayName: displayName,
                        url: url,
                        parentPath: url
                            .deletingLastPathComponent()
                            .path,
                        aliases: Self.makeAliases(
                            for: displayName
                        )
                    )
                )

            } catch {

                print(
                    "Failed to index:",
                    url.path,
                    error.localizedDescription
                )

            }

        }

    }

    nonisolated
    private static func makeAliases(
        for name: String
    ) -> [String] {

        let lower = name.lowercased()

        var aliases = Set<String>()

        aliases.insert(lower)

        let words = lower
            .split {
                $0 == " " ||
                $0 == "-" ||
                $0 == "_" ||
                $0 == "."
            }
            .map(String.init)

        aliases.formUnion(words)

        return aliases.sorted()

    }

    nonisolated
    private static func removeDuplicates(
        from entries: [IndexedItem]
    ) -> [IndexedItem] {

        var seenURLs = Set<URL>()

        return entries.filter { entry in

            seenURLs.insert(
                entry.url.standardizedFileURL
            ).inserted

        }

    }

}
