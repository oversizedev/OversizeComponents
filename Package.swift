// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OversizeComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "OversizeComponents",
            targets: ["OversizeComponents"]
        ),
        .library(
            name: "OversizeHealthComponents",
            targets: ["OversizeHealthComponents"]
        ),
    ],
    dependencies: [
        .package(name: "OversizeUI", path: "../OversizeUI"),
        // .package(name: "SlidingRuler", path: "../OversizeSlideRuler"),
        .package(name: "OversizeCore", path: "../OversizeCore"),
        .package(name: "OversizeServices", path: "../OversizeServices"),
        .package(name: "OversizeLocalizable", path: "../OversizeLocalizable"),
        // .package(url: "https://github.com/Pyroh/SlidingRuler", .upToNextMajor(from: "0.2.0")),
    ],
    targets: [
        .target(
            name: "OversizeComponents",
            dependencies: [
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeServices", package: "OversizeServices"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
            ]
        ),
        .target(
            name: "OversizeHealthComponents",
            dependencies: [
                .product(name: "OversizeUI", package: "OversizeUI"),
                // .product(name: "SlidingRuler", package: "SlidingRuler"),
                .product(name: "OversizeCore", package: "OversizeCore"),
            ]
        ),
        .testTarget(
            name: "OversizeComponentsTests",
            dependencies: ["OversizeComponents"]
        ),
    ]
)
