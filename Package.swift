// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Checkout3DS",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Checkout3DS",
            targets: ["Checkout3DS"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        )
    ],
    swiftLanguageVersions: [.v5]
)
