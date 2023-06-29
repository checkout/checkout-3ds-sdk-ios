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
    dependencies: [
        .package(
            url: "https://github.com/airsidemobile/JOSESwift.git",
            exact:"2.2.1"
        ),
        .package(
            url: "https://github.com/checkout/checkout-event-logger-ios-framework.git",
            from: "1.2.4"
        )
    ],
    targets: [
        .binaryTarget(
            name: "Checkout3DS",
            path: "Checkout3DS.xcframework"
        )
    ],
    swiftLanguageVersions: [.v5]
)
