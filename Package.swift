// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let localDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.0.2")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.5.0")),
    .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image.git", .upToNextMajor(from: "2.1.1")),
]

let remoteDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeUI", path: "../OversizeUI"),
    .package(name: "OversizeCore", path: "../OversizeCore"),
    .package(name: "OversizeLocalizable", path: "../OversizeLocalizable"),
    .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image.git", .upToNextMajor(from: "2.1.1")),
]

let dependencies: [PackageDescription.Package.Dependency] = remoteDependencies

let package = Package(
    name: "OversizeComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "OversizeComponents", targets: ["OversizeComponents"]),
        .library(name: "OversizePhotoComponents", targets: ["OversizePhotoComponents"]),
        .library(name: "OversizeHealthComponents", targets: ["OversizeHealthComponents"]),
        .library(name: "OversizeWeatherComponents", targets: ["OversizeWeatherComponents"]),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "OversizeComponents",
            dependencies: [
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
            ]
        ),
        .target(
            name: "OversizePhotoComponents",
            dependencies: [
                "OversizeComponents",
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
            ]
        ),
        .target(
            name: "OversizeHealthComponents",
            dependencies: [
                "OversizeComponents",
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeCore", package: "OversizeCore"),
            ]
        ),
        .target(
            name: "OversizeWeatherComponents",
            dependencies: [
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeCore", package: "OversizeCore"),
            ]
        ),
        .testTarget(
            name: "OversizeComponentsTests",
            dependencies: ["OversizeComponents"]
        ),
    ]
)
