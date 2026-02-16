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
      .package(url: "https://github.com/microsoft/plcrashreporter.git",
               exact: "1.12.0"),
      .package(url: "https://github.com/airsidemobile/JOSESwift.git",
               exact: "2.2.1")
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
        .target(
            name: "JOSESwiftDynamic",
            dependencies: ["JOSESwift"],
            path: "Dependencies/JOSESwiftDynamic/Sources"
        ),
        .target(name: "Checkout3DSWrapper",
                dependencies: [
                    .product(name: "CrashReporter", package: "plcrashreporter"),
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    "JOSESwiftDynamic",
                    .target(name: "Checkout3DSBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSWrapper"),
        .target(name: "Checkout3DSCoreWrapper",
                dependencies: [
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    "JOSESwiftDynamic",
                    .target(name: "Checkout3DSBinary",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-SecurityBinary",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSCore")
    ],
    swiftLanguageVersions: [.v5]
)
