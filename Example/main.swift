//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation

let environment = NSProcessInfo.processInfo().environment
guard let token = environment["TelegramExampleBotToken"] else {
    fatalError("Please set TelegramExampleBotToken environment variable")
}

let bot = TelegramBot(token: token)

class Controller {
    var update = Update()
    
    func help(arguments: Arguments) -> Bool {
        guard let message = update.message else { return false }
        bot.sendMessage(chatId: message.from.id, text: "Help text")
        return true
    }
}

let controller = Controller()

let router = Router()
router.addPath(["/help"], controller.help)

print("Ready to accept commands")
while let update = bot.nextUpdate() {
    print("--- updateId: \(update.updateId)")
    print("update: \(update.prettyPrint)")
    if let message = update.message, text = message.text {
        controller.update = update
        router.processString(text)
    }
}
fatalError("Server stopped due to error: \(bot.lastError)")
