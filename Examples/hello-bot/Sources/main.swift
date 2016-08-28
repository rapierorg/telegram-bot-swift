//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let token = readToken(from: "HELLO_BOT_TOKEN")

let bot = TelegramBot(token: token)

let router = Router(bot: bot)

router["help"] = { context in
	guard let from = context.message?.from else { return false }

	let helpText = "Usage: /greet"
    context.respondPrivatelyAsync(helpText,
        groupText: "\(from.first_name), please find usage instructions in a personal message.")
	return true
}

router["greet"] = { context in
	guard let from = context.message?.from else { return false }
    context.respondAsync("Hello, \(from.first_name)!")
	return true
}

router[.new_chat_member] = { context in
	guard let user = context.message?.new_chat_member else { return false }
	guard user.id != bot.user.id else { return false }
	context.respondAsync("Welcome, \(user.first_name)!")
	return true
}

print("Ready to accept commands")
while let update = bot.nextUpdateSync() {
	print("--- update: \(update.debugDescription)")

	try router.process(update: update)
}

fatalError("Server stopped due to error: \(bot.lastError)")
