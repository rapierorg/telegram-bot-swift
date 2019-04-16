// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rapier",
    products: [
        .library(
            name: "Rapier",
            targets: ["Rapier"]),
        .executable(
            name: "rapier",
            targets: ["RapierCLI"])
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/behrang/YamlSwift.git", from: "3.4.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Rapier",
            dependencies: ["Yaml"]),
        .target(
            name: "RapierCLI",
            dependencies: ["Yaml", "Rapier"]),
        .testTarget(
            name: "rapierTests",
            dependencies: ["RapierCLI"]),
    ]
)
