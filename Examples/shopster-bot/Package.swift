import PackageDescription

let package = Package(
    name: "shopster-bot",
    dependencies: [
        .Package(url: "../..", majorVersion: 0),
	    .Package(url: "https://github.com/zmeyc/GRDB.swift.git", majorVersion: 0)
    ]
)

