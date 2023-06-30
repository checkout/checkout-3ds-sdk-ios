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
                      checksum: "5e899dc2f7ac7be3668c1347b0633ab33f6b2ac93eccc26015ca87410ccb6a02"
        )
    ]
)
