import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {

    case general
    case search
    case ai
    case appearance
    case plugins
    case about

    var id: String { rawValue }

}

struct JAMWindows: View {
    @State
    private var selection: SidebarItem? = .general
    var body: some View {

        NavigationSplitView {

            List(selection: $selection) {

                Label("General", systemImage: "gearshape")
                    .tag(SidebarItem.general)

                Label("Search", systemImage: "magnifyingglass")
                    .tag(SidebarItem.search)

                Label("AI", systemImage: "sparkles")
                    .tag(SidebarItem.ai)

                Label("Appearance", systemImage: "paintbrush")
                    .tag(SidebarItem.appearance)

                Label("Plugins", systemImage: "puzzlepiece.extension")
                    .tag(SidebarItem.plugins)

                Label("About", systemImage: "info.circle")
                    .tag(SidebarItem.about)

            }
            .navigationTitle("JAM")

        } detail: {
            
            switch selection {

            case .general:

                GeneralView()

            case .search:

                SearchView()
                
            case .ai:

                Text("AI")

            case .appearance:

                Text("Appearance")

            case .plugins:

                Text("Plugins")

            case .about:

                AboutView()

            case nil:

                EmptyView()

            }

        }
    }

}
