// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Localize_Swift",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_13),
        .tvOS(.v9),
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
            exclude: ["UI/IBDesignable+Localize.swift", "UI/IBDesignable+Localize+AppKit.swift"],
            sources: ["."],
            resources: [])
    ],
    swiftLanguageVersions: [.v5]
)
