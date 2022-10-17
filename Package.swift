// swift-tools-version:5.3
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
            targets: ["Checkout3DS"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(name: "Checkout3DS", path: "Checkout3DS.xcframework"),
    ]
)
