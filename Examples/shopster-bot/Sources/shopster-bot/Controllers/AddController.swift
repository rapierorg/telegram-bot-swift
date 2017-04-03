//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

class AddController {
    typealias T = AddController
    
    init() {
        routers["add"] = Router(bot: bot) { router in
            router[Commands.help, .slashRequired] = onHelp
            router[Commands.cancel, .slashRequired] = onCancel
            router.unmatched = addItem
        }
    }
    
    func onHelp(context: Context) -> Bool {
        showHelp(context: context)
        return true
    }

    func onCancel(context: Context) throws -> Bool {
        try mainController.showMainMenu(context: context, text: "Cancelled")
        context.session.routerName = "main"
        try context.session.save()
        return true
    }
    
    func addItem(context: Context) throws -> Bool {
        guard let chatId = context.chatId else { return false }
        let name = context.args.scanRestOfString()
        guard name != Commands.add[0] else { return false } // Button pressed twice in a row
        try Item.add(name: name, chatId: chatId)
        try mainController.showMainMenu(context: context, text: "Added: \(name)")
        context.session.routerName = "main"
        try context.session.save()
        return true
    }
    
    func showHelp(context: Context) {
        let text = "Type a name to add or /cancel to cancel."
        
        if context.privateChat {
            context.respondAsync(text, reply_markup: ReplyKeyboardRemove())
        } else {
            let replyTo = context.message?.message_id
            var markup = ForceReply()
            markup.selective = replyTo != nil
            context.respondAsync(text,
                reply_to_message_id: replyTo,
                reply_markup: markup)
        }
    }
}
