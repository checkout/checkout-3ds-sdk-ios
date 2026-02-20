// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Checkout3DS",
    defaultLocalization: "en-GB",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Checkout3DS",
            targets: ["Checkout3DSWrapper"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
            from: "1.2.4"
        ),
        .package(
            url: "https://github.com/airsidemobile/JOSESwift.git",
            from: "2.4.0"
        )
    ],
    targets: [
        .target(
            name: "JOSESwift",
            path: "JOSESwiftStub"
        ),
        .binaryTarget(
            name: "Checkout3DSBinary",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS_SecurityBinary",
            path: "Checkout3DS-Security.xcframework"
        ),
        .target(
            name: "Checkout3DSWrapper",
            dependencies: [
                .product(name: "JOSESwift", package: "JOSESwift"),
                .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                "Checkout3DSBinary",
                "Checkout3DS_SecurityBinary"
            ],
            path: "Checkout3DSWrapper"
        )
    ],
    swiftLanguageVersions: [.v5]
)
