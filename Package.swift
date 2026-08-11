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
      .package(url: "https://github.com/airsidemobile/JOSESwift.git",
               exact: "2.4.0")
    ],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
        .target(
            name: "JOSESwiftDynamic",
            dependencies: ["JOSESwift"],
            path: "Dependencies/JOSESwiftDynamic/Sources"
        ),
        .target(name: "Checkout3DSPackages",
                dependencies: [
                    "JOSESwiftDynamic",
                    .target(name: "Checkout3DS", condition: .when(platforms: [.iOS])),
                ],
                path: "Checkout3DSPackages"
           )
    ],
    swiftLanguageVersions: [.v5]
)
