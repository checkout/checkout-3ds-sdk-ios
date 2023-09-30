// swift-tools-version:5.3

import PackageDescription
let package = Package(
    name: "Checkout3DSPackages",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Checkout3DSPackages",
            targets: ["Checkout3DSPackages"]
        )
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
        .binaryTarget(
            name: "JOSESwift",
            path: "Dependencies/JOSESwift.xcframework"
        ),
    .binaryTarget(
            name: "CheckoutEventLoggerKit",
            url: "https://github.com/checkout/checkout-event-logger-ios-framework/releases/download/1.2.4/CheckoutEventLoggerKit.xcframework.zip",
            checksum: "5db418477fc07baef7acceeb0e831f00872bc4fc9ba980e039ac1684cecbc145"
        ),
        .target(name: "Checkout3DSPackages",
                dependencies: [
                    .target(name: "JOSESwift", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "CheckoutEventLoggerKit", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS-Security", condition: .when(platforms: .some([.iOS])))
                ],
                path: "Checkout3DSPackages"
        )
    ],
    swiftLanguageVersions: [.v5]
)
