//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

class DeleteController {
    typealias T = DeleteController
    
    init() {
        routers["delete"] = Router(bot: bot) { router in
            router[Commands.help] = onHelp
            router[Commands.cancel] = onCancel
            router[Commands.confirmDeletion] = onConfirmDeletion
            router.unmatched = onCancel // safe default
        }
    }
    
    func onHelp(context: Context) -> Bool {
        let text = "/confirm_deletion Confirm deletion\n" +
            "/cancel Cancel"
        showConfirmationKeyboard(context: context, text: text)
        return true
    }
    
    func onCancel(context: Context) throws -> Bool {
        try mainController.showMainMenu(context: context, text: "Cancelled")
        context.session.routerName = "main"
        try context.session.save()
        return true
    }
    
    func onConfirmDeletion(context: Context) throws -> Bool {
        guard let chatId = context.chatId else { return false }
        try Item.deletePurchased(in: chatId)
        try mainController.showMainMenu(context: context, text: "Purchased items were deleted.")
        context.session.routerName = "main"
        try context.session.save()
        return true
    }
    
    func showConfirmationKeyboard(context: Context, text: String) {
        let replyTo = context.privateChat ? nil : context.message?.message_id
        
        var markup = ReplyKeyboardMarkup()
        //markup.one_time_keyboard = true
        markup.resize_keyboard = true
        markup.selective = replyTo != nil
        markup.keyboard_strings = [
            [ Commands.cancel[0], Commands.confirmDeletion[0] ]
        ]
        context.respondAsync(text,
                             reply_to_message_id: replyTo,
                             reply_markup: markup)
    }
}
