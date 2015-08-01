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
    let bot: TelegramBot
    var message: Message { return bot.lastMessage }
    
    init(bot: TelegramBot) {
        self.bot = bot
    }
    
    func help() {
        bot.sendMessage(chatId: message.from.id, text: "Help text")
    }

    func partialMatchHandler(unmatched: String, args: Arguments, path: Path) {
        bot.sendMessage(chatId: bot.lastMessage.chat.id,
            text: "❗ Part of your input was ignored: \(unmatched)")
    }

    func defaultHandler(args: Arguments) {
        let text = args["text"].stringValue
        
        bot.sendMessage(chatId: message.from.id, text: "You said: \(text)")
        
        if case .GroupChatType = message.chat {
            bot.sendMessage(chatId: message.chat.id, text: "\(message.from.firstName) said: \(text)")
        }
    }
}

let controller = Controller(bot: bot)

let router = Router(partialMatchHandler: controller.partialMatchHandler)
router.addPath(["/help"], controller.help)
router.addPath([RestOfString("text")], controller.defaultHandler)

print("Ready to accept commands")
while let command = bot.nextCommand() {
    print("--- updateId: \(bot.lastUpdate!.updateId)")
    print("message: \(bot.lastMessage.prettyPrint)")
    router.processString(command)
}
fatalError("Server stopped due to error: \(bot.lastError)")
