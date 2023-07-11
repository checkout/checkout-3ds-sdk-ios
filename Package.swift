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
            targets: ["Checkout3DS"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        ),
    ]
)
