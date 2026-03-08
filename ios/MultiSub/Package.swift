// swift-tools-version: 5.9
// NOTE: This file documents the dependency. In practice, add the
// convex-swift package via Xcode's "Package Dependencies" UI:
//   https://github.com/get-convex/convex-swift
//
// This file is NOT used directly since the iOS app is built
// as an Xcode project, not a SwiftPM executable.

import PackageDescription

let package = Package(
    name: "MultiSub",
    platforms: [.iOS(.v16)],
    dependencies: [
        .package(url: "https://github.com/get-convex/convex-swift", from: "0.8.1"),
    ],
    targets: [
        .executableTarget(
            name: "MultiSub",
            dependencies: [
                .product(name: "ConvexMobile", package: "convex-swift"),
            ],
            path: "."
        ),
    ]
)
