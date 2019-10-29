// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "shopster-bot",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "shopster-bot",
            targets: ["shopster-bot"]),
    ],
    dependencies: [
        .package(url: "../..", from: "1.2.3"),
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "4.5.0")
    ],
    targets: [
        .target(
            name: "shopster-bot",
            dependencies: ["TelegramBotSDK", "GRDB"]),
    ]
)

