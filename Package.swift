// swift-tools-version:5.3

import PackageDescription
let package = Package(
    name: "Checkout3DS",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Checkout3DS",
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
        .target(name: "Checkout3DSTargets",
                dependencies: [
                    .target(name: "JOSESwift", condition: .when(platforms: .some([.iOS]))),
                    .target(name: "Checkout3DS", condition: .when(platforms: .some([.iOS])))
                ],
                path: "Checkout3DSTargets"
        )
    ],
    swiftLanguageVersions: [.v5]
)
