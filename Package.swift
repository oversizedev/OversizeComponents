// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let productionDependencies: [PackageDescription.Package.Dependency] = { [
    .package(url: "http://github.com/oversizedev/OversizeUI.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeCore.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeServices.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeLocalizable.git", branch: "main"),
    .package(url: "http://github.com/oversizedev/OversizeResources.git", branch: "main"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.2"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.6.1"),
] }()

let developmentDependencies: [PackageDescription.Package.Dependency] = { [
    .package(name: "OversizeUI", path: "../OversizeUI"),
    .package(name: "OversizeCore", path: "../OversizeCore"),
    .package(name: "OversizeServices", path: "../OversizeServices"),
    .package(name: "OversizeLocalizable", path: "../OversizeLocalizable"),
    .package(name: "OversizeResources", path: "../OversizeResources"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.2"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.6.1"),
] }()

let package = Package(
    name: "OversizeComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v9),
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
        .library(
            name: "OversizeWeatherComponents",
            targets: ["OversizeWeatherComponents"]
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
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "SDWebImageSVGCoder", package: "SDWebImageSVGCoder"),
            ]
        ),
        .target(
            name: "OversizePhotoComponents",
            dependencies: [
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeResources", package: "OversizeResources"),
            ]
        ),
        .target(
            name: "OversizeHealthComponents",
            dependencies: [
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
                .product(name: "OversizeResources", package: "OversizeResources"),
            ]
        ),
        .testTarget(
            name: "OversizeComponentsTests",
            dependencies: ["OversizeComponents"]
        ),
    ]
)
