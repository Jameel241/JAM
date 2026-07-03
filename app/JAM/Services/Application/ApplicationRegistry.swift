import Foundation
import Combine

@MainActor
final class ApplicationRegistry: ObservableObject {

    static let shared = ApplicationRegistry()

    @Published
    private(set) var entries: [AppEntry] = []

    @Published
    private(set) var isIndexing = false

    @Published
    private(set) var lastIndexed: Date?

    @Published
    private(set) var lastError: Error?

    private init() {

        print("🚀 ApplicationRegistry initialized")

        Task {

            await rebuild()

        }

    }
    func rebuild() async {
        
        isIndexing = true
        lastError = nil

        entries.removeAll()

        let folders: [URL] = [

            URL(fileURLWithPath: "/Applications"),
            URL(fileURLWithPath: "/Applications/Utilities"),
            URL(fileURLWithPath: "/System/Applications"),
            URL(fileURLWithPath: "/System/Applications/Utilities"),
            URL(fileURLWithPath: NSHomeDirectory())
                .appendingPathComponent("Applications")

        ]

        for folder in folders {

            print("Scanning:", folder.path)

            guard let contents = try? FileManager.default.contentsOfDirectory(
                at: folder,
                includingPropertiesForKeys: nil
            ) else {
                continue
            }

            print("Found \(contents.count) items in \(folder.lastPathComponent)")

            for url in contents where url.pathExtension == "app" {

                let displayName = url
                    .deletingPathExtension()
                    .lastPathComponent

                let aliases = makeAliases(for: displayName)

                entries.append(
                    AppEntry(
                        displayName: displayName,
                        url: url,
                        aliases: aliases,
                        category: "Application"
                    )
                )
                print("Indexed:", displayName)
            }

        }
        print("Entries count:", entries.count)

        lastIndexed = Date()
        isIndexing = false

        print("Loaded \(entries.count) applications.")

    }

    func url(for name: String) -> URL? {

        entries.first {

            $0.aliases.contains(name.lowercased())

        }?.url

    }

    private func makeAliases(for name: String) -> [String] {

        let lower = name.lowercased()

        var aliases = Set<String>()

        aliases.insert(lower)

        let words = lower.split(separator: " ").map(String.init)

        aliases.formUnion(words)

        let acronym = words
            .compactMap(\.first)
            .map(String.init)
            .joined()

        if acronym.count > 1 {
            aliases.insert(acronym)
        }

        if lower.contains("google chrome") {
            aliases.insert("chrome")
            aliases.insert("google")
            aliases.insert("gc")
        }

        if lower.contains("visual studio code") {
            aliases.insert("vs")
            aliases.insert("vscode")
            aliases.insert("vsc")
            aliases.insert("code")
            aliases.insert("studio")
        }

        if lower.contains("final cut pro") {
            aliases.insert("fcp")
            aliases.insert("final")
            aliases.insert("cut")
        }

        if lower.contains("quicktime player") {
            aliases.insert("quicktime")
            aliases.insert("player")
            aliases.insert("qt")
        }

        if lower.contains("chatgpt") {
            aliases.insert("gpt")
            aliases.insert("chat")
        }

        if lower.contains("whatsapp") {
            aliases.insert("wa")
        }

        if lower.contains("youtube") {
            aliases.insert("yt")
            aliases.insert("tube")
        }

        return aliases.sorted()

    }

}
