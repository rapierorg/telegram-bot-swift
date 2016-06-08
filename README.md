# telegram-bot-swift

SDK for creating Telegram Bots in Swift.

<img src="https://github.com/zmeyc/telegram-bot-swift/wiki/img/word_reverse_bot.jpg" width=300>

Trivial bot:

```swift
import TelegramBot

let bot = TelegramBot(token: "my token")
let router = Router(bot)

router["greet"] = { context in
    guard let from = context.message.from else { return false }

    context.respondAsync("Hello, \(from.first_name)!")
    
    return true
}

while let update = bot.nextUpdateSync() {
    try router.process(update)
}

fatalError("Server stopped due to error: \(bot.lastError)")
```

## Telegram chat

Join our chat in Telegram: [swiftsdkchat](https://telegram.me/swiftsdkchat).

## Documentation

Build instructions and general information is available on [Telegram Bot Swift SDK Wiki](https://github.com/zmeyc/telegram-bot-swift/wiki).

Check `Examples/` for sample bot projects.

This SDK is a work in progress, expect the API to change very often.

## System Requirements

Only `Mac OS X` is supported right now. Linux is not YET supported because NSURLSession is not implemented in Linux version of Foundation.

Latest version requires `Swift 3.0 DEVELOPMENT-SNAPSHOT-2016-04-12-a`.
> Version 0.1 is the last Swift 2 compatible version (tag 0.1.0) and is unsupported.

If you're using X-Code, recommended version is `7.3`.

## Need help?

Please [submit an issue](https://github.com/zmeyc/telegram-bot-swift/issues) on Github.

If you miss a specific feature, please create an issue, this will speed up it's development. PR-s are also welcome.

Happy coding!

## License

MIT license. Please see LICENSE for more information.
