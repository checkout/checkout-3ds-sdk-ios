// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Checkout3DS",
    platforms: [
        .iOS(.v12)
    ],
   products: [
        .library(
            name: "Checkout3DSWrapper",
            targets: ["Checkout3DSWrapper", "Checkout3DS"]
        )
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
                .product(
                    name: "CheckoutEventLoggerKit",
                    package: "checkout-event-logger-ios-framework"),
                .product(
                    name: "JOSESwift",
                    package: "JOSESwift")
                ]
            ),
        .binaryTarget(
            name: "Checkout3DS",
            url: "https://github.com/checkout/checkout-3ds-sdk-ios/releases/download/3.0.0/Checkout3DS.xcframework.zip",
            checksum: "5e899dc2f7ac7be3668c1347b0633ab33f6b2ac93eccc26015ca87410ccb6a02"
        )
    ]
)
