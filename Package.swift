import PackageDescription

let package = Package(
    name: "telegram-bot-swift",
    dependencies: [
	    .Package(url: "https://github.com/zmeyc/CCurl.git", majorVersion: 0),
        .Package(url: "https://github.com/zmeyc/SwiftyJSON.git", majorVersion: 12),
        .Package(url: "https://github.com/smud/ScannerUtils.git", majorVersion: 1)
    ]
)

