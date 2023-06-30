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
        .binaryTarget(name: "Checkout3DS", 
                      url: "https://github.com/checkout/checkout-3ds-sdk-ios/files/11918166/Checkout3DS.xcframework.zip", 
                      checksum: "0b62c4355768a064a817f90688f9ba63f27cbee29a61b6bcb8639c2e1c59a0fd"
        )
    ]
)
