# telegram-bot-swift changelog

## 0.15.1 (2017-04-16)

- Switch to IBM's version of SwiftyJSON for Linux compatibility.

## 0.15.0 (2017-04-03)

- Memory leak fixed.

- Callback_query bug fixed.

- Message editing requests generation fixed.

- Better error reporting.

- Move back to original SwiftyJSON.

## 0.14.0 (2017-02-17)

- Library rewritten to use libcurl because Foundation's URLSession is not working reliably on Linux yet.

- File attachments are now supported (via InputFile). Check testSendPhoto() test in RequestTests.swift for an example.

## 0.13.0 (2016-12-04)

- Update to Bot API 2.3.1.

## 0.12.0 (2016-12-03)

- Linux port, thanks to Andrea de Marco who fixed most of the bugs!

- Telegram API updated to most recent one.

## 0.11.0 (2016-08-30)

- Updated to 2016-08-26 Swift toolchain.

## 0.10.0 (2016-07-03)

- Added `Examples/shopster-bot`: a sample bot which maintains a shopping list using sqlite3 database. [GRDB library](https://github.com/groue/GRDB.swift) is used for working with database. This bot allows creating shared shopping lists in group chats.

- Callback query data used in InlineButtons can now be parsed similarly to plaintext commands using arguments scanner. Simply call `context.args.scanWord()` to fetch a word from callback data and so on.

- Router path `.callback_query` now accepts nil: `callback_query(data: nil)`. Pass nil to match any data, then parse it in handler using arguments scanner.

- Router now supports context-sensitive user properties. Pass them to `process` method:

```swift
var properties = [String: AnyObject]()
properties["myField"] = myValue
try router.process(update: update, properties: properties)
```

And use them in handlers:

```swift
func myHandler(context: Context) -> Bool {
    let myValue = context.properties["myField"] as? MyValueType
    // ...
}
```

Or make a `Context` category for easier access to your properties, for example:

```swift
extension Context {
    var session: Session { return properties["session"] as! Session }
}
```

- Added `scanInt64()` to arguments scanner.

- `readToken("filename or env var")` is now `readToken(from: "filename or env var")`

## 0.9.0 (2016-06-27)

### Major changes:

- Project ported to Swift 3.0 Snapshot 2016-06-20 (a). Xcode8 is required.

- Types and Requests (methods) are now generated automatically from Telegram docs by a Ruby script located in `API/` directory.

- All types and requests are now supported.

- Optional parameters added to request signatures. This code:

```swift
bot.sendMessage(chatId, "text", ["reply_markup": markup])
```

Can now be written as:

```swift
bot.sendMessage(chatId, "text", reply_markup: markup)
```

You can still pass an array with additional arguments at the end of parameters list if needed.

### Other changes:

- Router now supports multiple comma separated paths:

```swift
router["List Items", "list"] = onListItems
```

- Router is now case insensitive by default.

- Multiword commands are now supported:

```swift
router["list add"] = onListAdd
router["list remove"] = onListRemove
```

- Router chaining is now supported. Use `handler` method to use Router as a handler:

`router1.unmatched = router2.handler`

- To force the use of slash, instead of `slash: .required` option use:

```swift
router["command", .slashRequired] = handler
```

Multiple flags can be specified:

```swift
router["command", [.caseSensitive, .slashRequired]] = handler
```

- `context.args.command` is now `context.command`.

- New variable: `context.slash`. True, if command was prefixed with a slash.

- `router.unknownCommand` handler renamed to `router.unmatched`

- Support `callback_query` in Router.

- `JsonObject` protocol renamed to `JsonConvertible`.

- `Context.message` is now optional. Also, it fallbacks to `edited_message` and `callback_query.message` when nil.

- Unknown command handler will no longer treat the first word as a command and will pass the entire string to a handler unchanged. `Context.command` will be empty.

- partialMatchHandler return value is now ignored. It can no longer cancel commands.

- All types changed from classes to structs.

- HTTP error codes except 401 (authentication error) are no longer fatal errors. TelegramBot will try to reconnect when encountering them.

## 0.8.0 (2016-06-15)

- Upgrade to Xcode 8 (Swift 3.0 Preview 1)
- Bugfix: "unknown command" / "unsupported content type" messages are no longer sent to group chats.

## 0.7.0 (2016-06-13)

- All enums renamed to match Swift 3 guidelines.
- Request function signatures changed: `parameters` label is no longer explicit, added missing enum to `sendChatAction` and a few other fixes.
- Bugfix: `ReplyKeyboardHide` is now JsonObject.
- Bugfix: getMeAsync is now public.
- Bugfix: default parameters now work correctly. For example, to disable notifications for all sendMessage calls, do:

```swift
bot.defaultParameters["sendMessage"] = {"disable_notification": true}
```

- `Int` now conforms to `JsonObject` and can be used as Request's return value.
- Fixed existing tests and added more tests.
- When trying to access the message via `context.message` non-optional shortcut and the message was nil initially, a warning will be printed.
- Added .new_chat_member router path to hello-bot sample project.


## 0.6.2 (2016-06-08)

- Ported to `Swift-DEVELOPMENT-SNAPSHOT-2016-06-06-a`.

## 0.6.0 (2016-06-08)

- Router handlers now take Context and return Bool. Other overloads were removed. This was done to simplify Router usage with closures. Closure signatures had to be specified explicitly, but now they can be inferred automatically.
- Message.from is now Optional.
- Add readConfigurationValue helper function which tries to read a single value from environment variable or from a file.
- Request methods are now snake case like structure fields to match Telegram Bot API docs.
- Examples updated to use the new API.
- Added all types and requests except inline types.
- Added missing fields which appeared in API 2.0 to all types.
- Router now works with Updates instead of Messages.
- Allow using raw JSON in requestAsync / requestSync.
- Chat and user ids are now Int64.

## 0.5.1 (2016-05-31)

Added `ReplyKeyboardMarkup` which can be used with `Strings`:

```swift
        let markup = ReplyKeyboardMarkup()
        markup.keyboardStrings = [["/a", "/b"], ["/c", "/d"]]
        context.respondAsync("Simple keyboard", parameters: ["reply_markup": markup])
```

Or with `KeyboardButtons`:

```swift
        let button1 = KeyboardButton()
        button1.text = "Request contact"
        button1.request_contact = true
        
        let button2 = KeyboardButton()
        button2.text = "Request location"
        button2.request_location = true

        markup.keyboardButtons = [ [ button1, button2 ] ]

        context.respondAsync("Another keyboard", parameters: ["reply_markup": markup])
```

## 0.5.0 (2016-05-30)

### Message context

The biggest change in this version is the addition of `context` in router handlers.
It's also an API breaking change.

Consider the old code below:

```swift
func commandHandler(args: Arguments) {
    bot.respondAsync("Hello, \(bot.lastMessage.from.first_name)") { // OK

        print("Succesfully sent message to \(bot.lastMessage.from.first_name)!")
        // BAD: bot.lastMessage was overwritten by nextMessage() at this point
        // and now belongs to another chat and/or user!

        bot.respondAsync("Bye!")
        // BAD: bot.respondAsync here will send the message to wrong user
        // because it uses lastMessage internally!
    }
}
```

You had to copy `lastMessage` before using it in async block, which was very error-prone:

```swift
func commandHandler(args: Arguments) {
    let message = bot.lastMessage
    bot.respondAsync("Hello, \(message.from.first_name)") { // OK
        print("Succesfully sent message to \(message.from.first_name)!") // OK
        bot.respondAsync("Bye!") // STILL BAD, uses bot.lastMessage internally
        bot.sendMessage(message.chat.id, "Bye!") // OK
    }
}
```

So, now router handlers have `context` parameter which contains:

- `bot`: a reference to bot.
- `message`: a copy of message.
- `args`: command arguments which can be fetched word-by-word etc.
- helper methods like `respondAsync`, `respondPrivately(groupText:)` etc.

The code above now works as expected without any additional steps:

```swift
func commandHandler(context: Context) {
    context.respondAsync("Hello, \(context.message.from.first_name)") { // OK
        print("Succesfully sent message to \(context.message.from.first_name)!") // OK
        context.respondAsync("Bye!") // OK
        bot.sendMessage(context.message.chat.id, "Bye!") // OK
    }
}
```
> It's ok to use global `bot` variable, but `context.bot` is also available. It doesn't matter which one you use.

The `hello-bot` and `word-reverse-bot` examples have been updated to use the new API.

Some helper methods were added to `Context` for frequently used variables.
For example, you can use:

- `context.fromId` in place of `context.message.from.id`
- `context.chatId` in place of `context.message.chat.id`
- `context.privateChat` in place of `context.message.chat.type == .privateChat`

### Router can now work with any message types

Another big change: router now accepts messages. You can do things like:

```swift
router[.newChatMember] = newChatMember
router[.leftChatMember] = leftChatMember
router[.document] = onDocument
etc

func newChatMember(context: Context) throws {
    let message = context.message
    guard let newChatMember = message.new_chat_member where
          newChatMember.id == bot.user.id else { return }

    ...someone invited bot to chat...
}
```

In addition to `partialMatch` handler there are two new fallback handlers:

```swift
router.partialMatch = partialMatchHandler
router.unknownCommand = unknownCommandHandler
router.unsupportedContentType = unsupportedContentTypeHandler
```

They have a reasonable default implementations, but can be overridden.

### Other changes

- `bot.lastCommand`, `bot.lastMessage` and `bot.lastUpdate` are no longer available. Added `bot.lastUpdateId` which can be used for debugging purposes.
- Added generic `requestSync` and `requestAsync` requests which can be used for any requests. All other requests now use these functions internally.
- All async request completion handlers now consistently return `(result, error)` tuple. Result type is different depending on request.
- Supported `array of objects` as request return value, simplified `getUpdates` request.
- Added `leaveChat` request.
- `Bool` type now conforms to `JsonObject` and can be used as request result. See `leaveChat` for example.

