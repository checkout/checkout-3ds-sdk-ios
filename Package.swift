// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Checkout3DSWrapper",
    platforms: [
        .iOS(.v12)
    ],
   products: [
        .library(
            name: "Checkout3DSWrapper",
            targets: ["Checkout3DSWrapper"]),
    ],
    dependencies: [
         .package(
            url: "https://github.com/checkout/checkout-3ds-sdk-ios",
            branch: "feature/PIMOB-2035_support_spm"),
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
                .product(
                    name: "Checkout3DS",
                    package: "checkout-3ds-sdk-ios"),
                .product(
                    name: "CheckoutEventLoggerKit",
                    package: "checkout-event-logger-ios-framework"),
                .product(
                    name: "JOSESwift",
                    package: "JOSESwift")
            ],
            path: "Checkout3DSWrapper"
        )
    ]
)
