import SwiftUI
import ConvexMobile

@main
struct MultiSubApp: App {
    @StateObject private var headerVM = HeaderViewModel()

    init() {
        initConvexLogging()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(headerVM)
        }
    }
}
