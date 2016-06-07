//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let token = readToken("HELLO_BOT_TOKEN")

let bot = TelegramBot(token: token)

let router = Router(bot: bot)

router["help"] = { context in
    let helpText = "Usage: /greet"
    context.respondPrivatelyAsync(helpText,
        groupText: "\(context.message.from.first_name), please find usage instructions in a personal message.")
	return true
}

router["greet"] = { context in
    context.respondAsync("Hello, \(context.message.from.first_name)!")
	return true
}

print("Ready to accept commands")
while let update = bot.nextUpdateSync() {
	print("--- update: \(update)")

	try router.process(update: update)
}

fatalError("Server stopped due to error: \(bot.lastError)")
