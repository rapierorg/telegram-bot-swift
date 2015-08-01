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
guard let botUser = bot.getMe(), username = botUser.username else {
    fatalError("Unable to fetch bot information")
}
let botName = BotName(username: username)

class Controller {
    var update = Update()
    
    func help() {
        guard let message = update.message else { return }
        bot.sendMessage(chatId: message.from.id, text: "Help text")
    }
    
    func defaultHandler(args: Arguments) {
        guard let text = args["text"] as? String else { fatalError() }
        guard let message = update.message else { return }
        bot.sendMessage(chatId: message.from.id, text: "You said: \(text)")
        bot.sendMessage(chatId: message.chat.id, text: "\(message.from.firstName) said: \(text)")
    }
}

let controller = Controller()

let router = Router()
router.addPath(["/help"], controller.help)
router.addPath([RestOfString("text")], controller.defaultHandler)

print("Ready to accept commands")
while let update = bot.nextUpdate() {
    print("--- updateId: \(update.updateId)")
    print("update: \(update.prettyPrint)")
    if let message = update.message, text = message.text,
            command = text.extractBotCommand(botName) {
        controller.update = update
        router.processString(command)
    }
}
fatalError("Server stopped due to error: \(bot.lastError)")
