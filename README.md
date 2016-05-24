# telegram-bot-swift

SDK for creating Telegram Bots (unofficial).

<img src="https://github.com/zmeyc/telegram-bot-swift/wiki/img/word_reverse_bot.jpg" width=300>

Trivial bot:

```swift
import TelegramBot

let bot = TelegramBot(token: "my token")
let router = Router(bot)

router["greet"] = { () -> () in
    bot.respondAsync("Hello, \(bot.lastMessage.from.first_name)!")
}

while let message = bot.nextMessageSync() {
    if let command = bot.lastCommand {
        try router.process(command)
    }
}

fatalError("Server stopped due to error: \(bot.lastError)")
```

## Documentation

Check `Examples/` for sample bot projects.

Build instructions and general information is available on [Telegram Bot Swift SDK Wiki](https://github.com/zmeyc/telegram-bot-swift/wiki).

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
