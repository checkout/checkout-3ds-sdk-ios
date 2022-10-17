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
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework",
            revision: "1.2.0"),
        .package(
            url: "https://github.com/airsidemobile/JOSESwift",
            revision: "2.4.0")
    ],
    targets: [
        .target(
            name: "Checkout3DSWrapper",
            dependencies: [
                .target(name: "Checkout3DS"),
                .product(
                    name: "CheckoutEventLoggerKit",
                    package: "checkout-event-logger-ios-framework"),
                .product(
                    name: "JOSESwift",
                    package: "JOSESwift")
            ],
            path: "Wrapper"
        ),
        .binaryTarget(name: "Checkout3DS", path: "Checkout3DS.xcframework"),
    ]
)
