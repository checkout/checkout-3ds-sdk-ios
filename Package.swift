// swift-tools-version:5.3

import PackageDescription
let package = Package(
    name: "Checkout3DSTargets",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Checkout3DSTargets",
            targets: ["Checkout3DSTargets"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
        .binaryTarget(
            name: "JOSESwift",
            path: "JOSESwift.xcframework"
        ),
    .binaryTarget(
            name: "CheckoutEventLoggerKit",
            url: "https://github.com/checkout/checkout-event-logger-ios-framework/releases/download/1.2.4/CheckoutEventLoggerKit.xcframework.zip",
            checksum: "5db418477fc07baef7acceeb0e831f00872bc4fc9ba980e039ac1684cecbc145"
        ),
        .target(name: "Checkout3DSTargets",
                dependencies: [
                    .target(name: "JOSESwift", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "CheckoutEventLoggerKit", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS", condition: .when(platforms: .some([.iOS])))
                ],
                path: "Checkout3DSTargets"
        )
    ],
    swiftLanguageVersions: [.v5]
)
