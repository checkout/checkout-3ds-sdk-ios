// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Checkout3DS",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Checkout3DS",
            targets: ["Checkout3DSWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/airsidemobile/JOSESwift.git", .exact("2.2.1")),
        .package(name: "CheckoutEventLoggerKit", url: "https://github.com/checkout/checkout-event-logger-ios-framework.git", .exact("1.0.3"))
    ],
    targets: [
        .target(
            name: "Checkout3DSWrapper",
            dependencies: ["Checkout3DS", "CheckoutEventLoggerKit", "JOSESwift"]
        ),
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
    ]
)
