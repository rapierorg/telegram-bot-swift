//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

print("Checking if database is up to date")

do {
    try MigrationController.migrate()
} catch {
    print("Error while migrating the database: \(error)")
    exit(1)
}

// Add SHOPSTER_BOT_TOKEN to environment variables or create a file named 'SHOPSTER_BOT_TOKEN'
// containing your bot's token in app's working dir.
let token = readToken(from: "SHOPSTER_BOT_TOKEN")

let bot = TelegramBot(token: token)
var routers = [String: Router]()

let mainController = MainController()
let addController = AddController()
let deleteController = DeleteController()

// Disable sendMessage notifications by default
bot.defaultParameters["sendMessage"] = ["disable_notification": true]

print("Ready to accept commands")

while let update = bot.nextUpdateSync() {
    update.prettyPrint()

    // Properties associated with request context
    var properties = [String: AnyObject]()

    // ChatId is needed for choosing a router associated with particular chat
    guard let chatId = update.message?.chat.id ??
        update.callback_query?.message?.chat.id else {
            continue
    }

    do {
        // Fetch Session object from database. It will be created if missing.
        let session = try Session.session(for: chatId)
        
        // Fetching from database is expensive operation. Store the session
        // in properties to avoid fetching it again in handlers
        properties["session"] = session
        
        let router = routers[session.routerName]
        if let router = router {
            try router.process(update: update, properties: properties)
        } else {
            print("Warning: chat \(chatId) has invalid router: \(session.routerName)")
        }
    } catch {
        bot.reportErrorAsync(chatId: chatId,
                             text: "❗ Error while performing the operation.",
                             errorDescription: "Recovered from exception: \(error)")
    }
}

print("Server stopped due to error: \(bot.lastError.unwrapOptional)")
exit(1)
