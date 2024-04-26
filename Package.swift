// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Multitude",
    platforms: [.macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Multitude",
            targets: ["Multitude"]
        ),
        .library(
            name: "MultitudeArray",
            targets: ["MultitudeArray"]
        ),
        .library(
            name: "MultitudeSIMD",
            targets: ["MultitudeSIMD"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/OperatorFoundation/Datable", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Multitude",
            dependencies: [
                "Datable",
            ]
        ),
        .target(
            name: "MultitudeArray",
            dependencies: [
                "Multitude",

                "Datable",
            ]
        ),
        .target(
            name: "MultitudeSIMD",
            dependencies: [
                "Multitude",

                "Datable",
            ]
        ),
        .testTarget(
            name: "MultitudeTests",
            dependencies: [
                "Multitude",
                "MultitudeArray",
                "MultitudeSIMD",
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
