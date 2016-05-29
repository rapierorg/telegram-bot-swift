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

router["help"] = { (context: Context) -> () in
    let helpText = "Usage: /greet"
    context.respondPrivatelyAsync(helpText,
        groupText: "\(context.message.from.first_name), please find usage instructions in a personal message.")
}

router["greet"] = { (context: Context) -> () in
    context.respondAsync("Hello, \(context.message.from.first_name)!")
}

print("Ready to accept commands")
while let message = bot.nextMessageSync() {
	print("--- update_id: \(bot.lastUpdateId)")
	print("message: \(message.debugDescription)")

	try router.process(message: message)
}

fatalError("Server stopped due to error: \(bot.lastError)")
