import PackageDescription

let package = Package(
    name: "telegram-bot-swift",
    dependencies: [
      .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 6, minor: 0)
    ]
)

