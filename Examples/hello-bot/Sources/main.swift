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

router["help"] = { ()->() in
    let helpText = "Usage: /greet"
    bot.respondPrivatelyAsync(helpText,
        groupText: "\(bot.lastMessage.from.first_name), please find usage instructions in a personal message.")
}

router["greet"] = { ()->() in
    bot.respondAsync("Hello, \(bot.lastMessage.from.first_name)!")
}

print("Ready to accept commands")
while let message = bot.nextMessageSync() {
	print("--- update_id: \(bot.lastUpdate!.update_id)")
	print("message: \(message.debugDescription)")
	print("command: \(bot.lastCommand.unwrapOptional)")

	if let command = bot.lastCommand {
		try router.process(command)
	}
}
fatalError("Server stopped due to error: \(bot.lastError)")
