// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Checkout3DS",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Checkout3DS",
            type: .dynamic,
            targets: ["Checkout3DS"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework",
            revision: "1.2.4"),
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
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        )
    ],
    swiftLanguageVersions: [.v5]
)
