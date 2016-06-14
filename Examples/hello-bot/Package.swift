import PackageDescription

let package = Package(
    name: "hello-bot",
    dependencies: [
        .Package(url: "../..", majorVersion: 0)
    ]
)

