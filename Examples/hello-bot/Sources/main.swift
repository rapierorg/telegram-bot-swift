//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let environment = NSProcessInfo.processInfo().environment
guard let token = environment["HELLO_BOT_TOKEN"] else {
    fatalError("Please set HELLO_BOT_TOKEN environment variable")
}

let bot = TelegramBot(token: token)

let router = Router()

router.add(Command("help")) { () -> () in
    let helpText = "Usage: /greet"
    bot.respondPrivatelyAsync(helpText,
        groupText: "\(bot.lastMessage.from.first_name), please find usage instructions in a personal message.")
}

router.add(Command("greet")) { () -> () in
    bot.respondAsync("Hello, \(bot.lastMessage.from.first_name)!")
}

// Default handler
router.fallbackHandler = .NonCancellableHandlerWithArguments({ (args: ArgumentScanner) -> () in
    let text = args.scanRestOfString()
    bot.respondAsync("I don't understand \(text).\n" +
        "Usage: /greet")
})

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
