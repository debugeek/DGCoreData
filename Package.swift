// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DGCoreData",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10)
    ],
    products: [
        .library(name: "DGCoreData", targets: ["DGCoreData"])
    ],
    targets: [
        .target(name: "DGCoreData")
    ]
)
