// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "JOSESwiftDynamic",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "JOSESwiftDynamic", type: .dynamic, targets: ["JOSESwiftDynamic"])
    ],
    dependencies: [
        .package(url: "https://github.com/airsidemobile/JOSESwift.git", from: "2.2.1")
    ],
    targets: [
        .target(
            name: "JOSESwiftDynamic", dependencies: ["JOSESwift"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
