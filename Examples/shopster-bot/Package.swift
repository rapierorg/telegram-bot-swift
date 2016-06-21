import PackageDescription

let package = Package(
    name: "shopster-bot",
    dependencies: [
        .Package(url: "../..", majorVersion: 0),
        .Package(url: "https://github.com/zmeyc/CSQLite.git", majorVersion: 0)
    ]
)

