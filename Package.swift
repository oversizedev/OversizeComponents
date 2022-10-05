// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let productionDependencies: [PackageDescription.Package.Dependency] = { [
    .package(url: "http://github.com/oversizedev/OversizeUI.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeCore.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeServices.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeLocalizable.git", branch: "main"),
]}()

let developmentDependencies: [PackageDescription.Package.Dependency] = { [
    .package(name: "OversizeUI", path: "../OversizeUI"),
    .package(name: "OversizeCore", path: "../OversizeCore"),
    .package(name: "OversizeServices", path: "../OversizeServices"),
    .package(name: "OversizeLocalizable", path: "../OversizeLocalizable"),
]}()


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
    dependencies: productionDependencies,
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
