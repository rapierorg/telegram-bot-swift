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

router.addPath([Command("help")]) { () -> () in
    let helpText = "Usage: /greet"
    bot.respondPrivatelyAsync(helpText,
        groupText: "\(bot.lastMessage.from.firstName), please find usage instructions in a personal message.")
}

router.addPath([Command("greet")]) { () -> () in
    bot.respondAsync("Hello, \(bot.lastMessage.from.firstName)!")
}

// Default handler
router.addPath([RestOfString("text")]) { (args: Arguments) -> () in
    let text = args["text"].stringValue
    bot.respondAsync("I don't understand \(text).\n" +
        "Usage: /greet")
}

print("Ready to accept commands")
while let command = bot.nextCommandSync() {
    print("--- updateId: \(bot.lastUpdate!.updateId)")
    print("message: \(bot.lastMessage.prettyPrint)")
    try router.processString(command)
}
fatalError("Server stopped due to error: \(bot.lastError)")

