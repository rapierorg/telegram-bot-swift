# telegram-bot-swift changelog

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

