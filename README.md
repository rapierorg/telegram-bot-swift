# telegram-bot-swift
Telegram Bot SDK for Swift (unofficial)

This SDK is a work in progress, expect the API to change very often.

Supports `Mac OS X` only right now. Linux is not YET supported because NSURLSession is not implemented.

Latest version requires `Swift 3.0 DEVELOPMENT-SNAPSHOT-2016-04-12-a`.

If you're using X-Code, recommended version is `7.3`. 'swift build' is also supported.

Version 0.1 is the last Swift 2 compatible version (tag 0.1.0).

## How to start:

Install Swift 3.0 DEVELOPMENT-SNAPSHOT-2016-04-12-a following instructions on https://swift.org

**git clone https://github.com/zmeyc/telegram-bot-example-swift.git**

```
Cloning into 'telegram-bot-example-swift'...
remote: Counting objects: 23, done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 23 (delta 7), reused 16 (delta 3), pack-reused 0
Unpacking objects: 100% (23/23), done.
Checking connectivity... done.
```

**cd telegram-bot-example-swift**

**make**

```
swift build -Xswiftc -j8
Cloning https://github.com/zmeyc/telegram-bot-swift.git
Resolved version: 0.2.0
Cloning https://github.com/IBM-Swift/SwiftyJSON.git
Resolved version: 6.0.0
Compiling Swift Module 'SwiftyJSON' (3 sources)
Compiling Swift Module 'TelegramBot' (43 sources)
Compiling Swift Module 'telegrambotexampleswift' (1 sources)
Linking .build/debug/telegram-bot-example-swift
```

Add your bot's token to ~/.profile:

```
export TELEGRAM_EXAMPLE_BOT_TOKEN="bot token obtained from BotFather"
```

Reload the environment variables by calling:

**source ~/.profile**

Run the bot:

**.build/debug/telegram-bot-example-swift**

```
Ready to accept commands
```

Chat with the bot in Telegram or add it to groups (send /start to activate it).

API docs and details on generating Xcode project will be added later.

For help requests, please open issues in main repository:
https://github.com/zmeyc/telegram-bot-swift/issues

If you miss a specific feature, please create an issue, this will speed up it's development. PR-s are also welcome.

Happy coding!
