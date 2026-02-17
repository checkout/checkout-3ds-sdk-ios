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
      .package(url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
               exact: "1.2.4"),
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
            name: "Checkout3DSCoreBinary",
            path: "Checkout3DSCore.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS-SecurityBinary",
            path: "Checkout3DS-Security.xcframework"
        ),
        .target(name: "Checkout3DSWrapper",
                dependencies: [
                    "JOSESwift",
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    .target(name: "Checkout3DSBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSWrapper"),
        .target(name: "Checkout3DSCoreWrapper",
                dependencies: [
                    "JOSESwift",
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    // We point to Checkout3DSCoreBinary, which is physically located in Checkout3DSCore.xcframework.
                    // Internally, this binary will eventually identify as "Checkout3DS", but for SPM distribution
                    // we keep the binary target name distinct to avoid Package.swift validation errors about duplicate products/artifacts.
                    .target(name: "Checkout3DSCoreBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSCore")
    ],
    swiftLanguageVersions: [.v5]
)
