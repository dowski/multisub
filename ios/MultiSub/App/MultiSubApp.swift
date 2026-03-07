import SwiftUI
import ConvexMobile

@main
struct MultiSubApp: App {
    @StateObject private var headerVM = HeaderViewModel()
    @StateObject private var natureVM = NatureTabViewModel()
    @StateObject private var gamesVM = GamesTabViewModel()
    @StateObject private var vibesVM = VibesTabViewModel()
  
  init() {
    initConvexLogging()
  }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(headerVM)
                .environmentObject(natureVM)
                .environmentObject(gamesVM)
                .environmentObject(vibesVM)
        }
    }
}
