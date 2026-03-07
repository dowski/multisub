import SwiftUI

struct ContentView: View {
    @EnvironmentObject var headerVM: HeaderViewModel
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()

            Divider()

            TabView(selection: $selectedTab) {
                NavigationStack {
                    NatureTabView()
                }
                .tabItem {
                    Label("Nature", systemImage: "leaf.fill")
                }
                .tag(0)

                NavigationStack {
                    GamesTabView()
                }
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .tag(1)

                NavigationStack {
                    VibesTabView()
                }
                .tabItem {
                    Label("Vibes", systemImage: "sparkles")
                }
                .tag(2)
            }

            Divider()

            TriggerButton()
        }
    }
}
