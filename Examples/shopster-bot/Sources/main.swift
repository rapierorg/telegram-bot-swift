//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let token = readToken("SHOPSTER_BOT_TOKEN")
let bot = TelegramBot(token: token)
let mainController = MainController(bot: bot)

print("Ready to accept commands")

while let update = bot.nextUpdateSync() {
    update.prettyPrint()
    
    do {
        try mainController.router.process(update: update)
    } catch {
        bot.reportErrorAsync(chatId: update.message?.chat.id,
                             text: "❗ Error while performing the operation.",
                             errorDescription: "Recovered from exception: \(error)")
    }
}

fatalError("Server stopped due to error: \(bot.lastError)")
