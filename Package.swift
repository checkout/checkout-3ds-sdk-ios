// swift-tools-version:5.3

import PackageDescription
let package = Package(
    name: "Checkout3DSPackages",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Checkout3DSPackages",
            targets: ["Checkout3DSPackages"] )
    ],
    dependencies: [
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
            from: "1.2.5"),
        .package(
             url: "https://github.com/microsoft/plcrashreporter.git",
             from: "1.12.0"),
        .package(name: "JOSESwiftDynamic",
                 path: "Dependencies/JOSESwiftDynamic")
    ],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS-Security",
            path: "Checkout3DS-Security.xcframework"
        ),
        .target(name: "Checkout3DSPackages",
                dependencies: [
                    .product(name: "CrashReporter", package: "plcrashreporter"),
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    .product(name: "JOSESwiftDynamic", package: "JOSESwiftDynamic"),
                    .target(name: "Checkout3DS", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS-Security", condition: .when(platforms: .some([.iOS])))
                ],
                path: "Checkout3DSPackages",
                linkerSettings: [.linkedFramework("CheckoutEventLoggerKit")])
    ],
    swiftLanguageVersions: [.v5]
)
