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
            targets: ["Checkout3DSPackages"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
            from: "1.2.4"
        )],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "Checkout3DS-Security",
            path: "Checkout3DS-Security.xcframework"
        ),
        .binaryTarget(
            name: "JOSESwift",
            path: "Dependencies/JOSESwift.xcframework"
        ),
        .target(name: "Checkout3DSPackages",
                dependencies: [
                    .product(name: "CheckoutEventLoggerKit",
                             package: "checkout-event-logger-ios-framework"),
                    .target(name: "JOSESwift", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS-Security", condition: .when(platforms: .some([.iOS])))
                ],
                path: "Checkout3DSPackages",
                linkerSettings: [.linkedFramework("CheckoutEventLoggerKit"),
                                 .linkedFramework("Checkout3DS-Security")])
    ],
    swiftLanguageVersions: [.v5]
)
