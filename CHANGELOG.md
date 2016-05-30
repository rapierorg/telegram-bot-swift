# telegram-bot-swift changelog

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

