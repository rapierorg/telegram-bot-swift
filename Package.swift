import PackageDescription

let package = Package(
    name: "telegram-bot-swift",
    dependencies: [
      .Package(url: "https://github.com/zmeyc/SwiftyJSON.git", majorVersion: 12)
    ]
)

