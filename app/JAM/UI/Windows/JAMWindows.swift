import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {

    case general
    case search
    case ai
    case appearance
    case privacy
    case plugins
    case updates
    case about

    var id: String { rawValue }

}

struct JAMWindows: View {
    @State
    private var selection: SidebarItem? = .general
    var body: some View {
        
        NavigationSplitView {
            
            List(selection: $selection) {
                
                Section {  Label("General", systemImage: "gearshape")
                        .tag(SidebarItem.general)
                    
                    Label("Search", systemImage: "magnifyingglass")
                        .tag(SidebarItem.search)
                    
                    Label("AI", systemImage: "sparkles")
                        .tag(SidebarItem.ai)
                    
                    Label("Appearance", systemImage: "paintbrush")
                    .tag(SidebarItem.appearance)}
                
                Section {   Label("Privacy", systemImage: "lock.shield")
                        .tag(SidebarItem.privacy)
                    
                    Label("Plugins", systemImage: "puzzlepiece.extension")
                        .tag(SidebarItem.plugins)
                    
                    Label("Updates", systemImage: "arrow.triangle.2.circlepath")
                    .tag(SidebarItem.updates)}
                
                Section {   Label("About", systemImage: "info.circle")
                    .tag(SidebarItem.about)}
                
            }
            .navigationTitle("JAM")
            
        }detail:{
            
            switch selection {
                
            case .general:
                
                GeneralView()
                
            case .search:
                
                SearchView()
                
            case .ai:
                AIView()
                
            case .appearance:
                
                AppearanceView()
                
            case .privacy:
                
                PrivacyView()
                
            case .plugins:
                
                PluginsView()
                
            case .updates:
                
                UpdatesView()
                
            case .about:
                
                AboutView()
                
            case nil:
                
                EmptyView()
                
            }
            
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: .openGeneralSettings
            )
        ) { _ in

            selection = .general

        }

        .onReceive(
            NotificationCenter.default.publisher(
                for: .openAboutSettings
            )
        ) { _ in

            selection = .about

        }
        
    }
        
    
    
}
     

    
    
