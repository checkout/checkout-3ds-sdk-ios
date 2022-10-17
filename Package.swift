// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "checkout3ds-sdk-ios",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Checkout3DS",
            targets: ["Checkout3DSWrapper"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Checkout3DSWrapper",
            dependencies: [
                .target(name: "Checkout3DS"),
            ],
            path: "Wrapper"
        ),
        .binaryTarget(name: "Checkout3DS", path: "Checkout3DS.xcframework"),
    ]
)
