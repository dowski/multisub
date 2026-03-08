import ConvexMobile

enum ConvexClientProvider {
    // Replace with your Convex deployment URL or your machine's LAN IP for on-device testing.
    static let client = ConvexClient(deploymentUrl: "http://127.0.0.1:3210")
}
