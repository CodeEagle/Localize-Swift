// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "Localize_Swift",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "Localize_Swift",
            targets: ["Localize_Swift"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Localize_Swift",
            path: "Sources",
            sources: ["."],
            resources: [])
    ],
    swiftLanguageModes: [.v6]
)
