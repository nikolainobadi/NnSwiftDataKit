// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnSwiftDataKit",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "NnSwiftDataKit",
            targets: ["NnSwiftDataKit"]),
    ],
    targets: [
        .target(
            name: "NnSwiftDataKit"),
    ]
)
