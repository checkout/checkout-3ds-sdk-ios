// swift-tools-version:5.10

import PackageDescription
let package = Package(
    name: "Checkout3DS",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Checkout3DS",
                 targets: ["Checkout3DSWrapper"]),
        .library(name: "Checkout3DSCore",
                 targets: ["Checkout3DSCoreWrapper"])
    ],
    dependencies: [
      .package( url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
                from: "1.2.4"),
    ],
    targets: [
        .binaryTarget(
            name: "Checkout3DSBinary",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DSCoreBinary",
            path: "Checkout3DSCore.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS-SecurityBinary",
            path: "Checkout3DS-Security.xcframework"
        ),
        .target(name: "Checkout3DSWrapper",
                dependencies: [
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    .target(name: "Checkout3DSBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSWrapper"),
        .target(name: "Checkout3DSCoreWrapper",
                dependencies: [
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    .target(name: "Checkout3DSCoreBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSCore")
    ],
    swiftLanguageVersions: [.v5]
)
