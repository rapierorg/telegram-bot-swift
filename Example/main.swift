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

while let update = bot.nextUpdate() {
    print("--- updateId: \(update.updateId)")
    print("update: \(update.prettyPrint)")
    if let message = update.message, text = message.text {
        if text == "Hello" {
            bot.sendMessage(chatId: message.from.id, text: "How are you?")
        }
    }
}
fatalError("Server stopped due to error: \(bot.lastError)")
