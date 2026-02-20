// swift-tools-version:5.10

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
      .package( url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
                exact: "1.2.4"),
      .package(url: "https://github.com/airsidemobile/JOSESwift.git",
               exact: "2.4.0")
    ],
    targets: [
        .target(
            name: "JOSESwift",
            path: "JOSESwiftStub"
        ),
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS-Security",
            path: "Checkout3DS-Security.xcframework"
        ),
        .target(
            name: "JOSESwiftDynamic",
            dependencies: ["JOSESwift"],
            path: "Dependencies/JOSESwiftDynamic/Sources"
        ),
        .target(name: "Checkout3DSPackages",
                dependencies: [
                    .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                    "JOSESwiftDynamic",
                    .target(name: "Checkout3DS",
                            condition: .when(platforms: [.iOS])),
                    .target(name: "Checkout3DS-Security",
                            condition: .when(platforms: [.iOS]))
                ],
                path: "Checkout3DSPackages")
    ],
    swiftLanguageVersions: [.v5]
)
