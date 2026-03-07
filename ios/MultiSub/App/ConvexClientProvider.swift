import ConvexMobile

enum ConvexClientProvider {
    // Replace with your actual Convex deployment URL.
    // For local dev, this would be something like "http://192.168.2.2:3210"
    static let client = ConvexClient(deploymentUrl: "http://192.168.2.2:3210")
}
