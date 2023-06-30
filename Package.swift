// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Checkout3DS",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library( name: "Checkout3DS", targets: ["Checkout3DS"])
    ],
    targets: [
        .binaryTarget( name: "Checkout3DS", url: "https://github.com/checkout/checkout-3ds-sdk-ios/archive/refs/tags/3.0.0.zip" )
    ]
)
