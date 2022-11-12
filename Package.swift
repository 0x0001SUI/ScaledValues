// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "ScaledValues",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "ScaledValues",
            targets: ["ScaledValues"]),
    ],
    targets: [
        .target(
            name: "ScaledValues",
            dependencies: []),
        .testTarget(
            name: "ScaledValuesTests",
            dependencies: ["ScaledValues"]),
    ]
)
