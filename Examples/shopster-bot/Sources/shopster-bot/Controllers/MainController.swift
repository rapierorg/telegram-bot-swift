//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

class MainController {
    typealias T = MainController

    init() {
        routers["main"] = Router(bot: bot) { router in
            router[Commands.start] = onStart
            router[Commands.stop] = onStop
            router[Commands.help] = onHelp
            router[Commands.add] = onAdd
            router[Commands.delete] = onDelete
            router[Commands.list] = onList
            router[Commands.support] = onSupport
            router[.new_chat_member] = onNewChatMember
            router[.callback_query(data: nil)] = onCallbackQuery
        }
    }
    
    func onStart(context: Context) throws -> Bool {
        try showMainMenu(context: context, text: "Please choose an option.")
        return true
    }
    
    func onStop(context: Context) -> Bool {
        let replyTo = context.privateChat ? nil : context.message?.message_id
        
        var markup = ReplyKeyboardHide()
        markup.selective = replyTo != nil
        context.respondAsync("Stopping.",
                             reply_to_message_id: replyTo,
                             reply_markup: markup)
        return true
    }

    
    func onHelp(context: Context) throws -> Bool {
        let text = "Usage:\n" +
            "/add name - add a new item to list\n" +
            "/list - list items\n" +
            "/delete - delete purchased items from list\n" +
            "/support - join the support group"
        try showMainMenu(context: context, text: text)
        return true
    }
    
    func onAdd(context: Context) throws -> Bool {
        guard let chatId = context.chatId else { return false }
        let name = context.args.scanRestOfString()
        if name.isEmpty {
            addController.showHelp(context: context)
            context.session.routerName = "add"
            try context.session.save()
        } else {
            try Item.add(name: name, chatId: chatId)
            context.respondAsync("Added: \(name)")
        }
        return true
    }
    
    func onDelete(context: Context) throws -> Bool {
        deleteController.showConfirmationKeyboard(context: context, text: "Delete purchased items? /confirm_deletion or /cancel")
        context.session.routerName = "delete"
        try context.session.save()
        return true
    }
    
    func onList(context: Context) -> Bool {
        guard let markup = itemListInlineKeyboardMarkup(context: context) else { return false }
        context.respondAsync("Item List:",
                             reply_markup: markup)
        return true
    }

    func onSupport(context: Context) -> Bool {
        // Please update support group name to point to your group!
        // Don't send people to Zabiyaka Support group.
        // Delete this guard condition when this is done.
        guard bot.username.lowercased().hasPrefix("shopster") else {
            context.respondAsync("Invalid support URL.")
            return true
        }

        var button = InlineKeyboardButton()
        button.text = "Join Zabiyaka Support"
        button.url = "https://telegram.me/zabiyaka_support"
        
        var markup = InlineKeyboardMarkup()
        let keyboard = [[button]]
        markup.inline_keyboard = keyboard

        context.respondAsync("Please click the button below to join *Zabiyaka Support* group.", parse_mode: "Markdown", reply_markup: markup)

        return true
    }

    func onNewChatMember(context: Context) -> Bool {
        guard let newChatMember = context.message?.new_chat_member,
            newChatMember.id == bot.user.id else { return false }
        
        context.respondAsync("Hi All. I'll maintain your shared shopping list. Type /start to start working with me.")
        return true
    }
    
    func onCallbackQuery(context: Context) throws -> Bool {
        guard let chatId = context.update.callback_query?.message?.chat.id else { return false }
        guard let messageId = context.update.callback_query?.message?.message_id else { return false }

        // "toggle 1234567"
        guard context.args.scanWord() == "toggle" else { return false }
        guard let itemId = context.args.scanInt64() else { return false }
        
        guard let item = try Item.item(itemId: itemId, from: chatId) else {
            context.respondAsync("This item no longer exists.")
            return true
        }
        item.purchased = !item.purchased
        try item.save()
        
        if let markup = itemListInlineKeyboardMarkup(context: context) {
            bot.editMessageReplyMarkupAsync(chat_id: chatId, message_id: messageId, reply_markup: markup)
        }
        return true
    }
    
    func showMainMenu(context: Context, text: String) throws {
        // Use replies in group chats, otherwise bot won't be able to see the text typed by user.
        // In private chats don't clutter the chat with quoted replies.
        let replyTo = context.privateChat ? nil : context.message?.message_id
        
        var markup = ReplyKeyboardMarkup()
        //markup.one_time_keyboard = true
        markup.resize_keyboard = true
        markup.selective = replyTo != nil
        markup.keyboard_strings = [
            [ Commands.add[0], Commands.list[0], Commands.delete[0] ],
            [ Commands.help[0], Commands.support[0] ]
        ]
        context.respondAsync(text,
            reply_to_message_id: replyTo, // ok to pass nil, it will be ignored
            reply_markup: markup)
        
    }

    func itemListInlineKeyboardMarkup(context: Context) -> InlineKeyboardMarkup? {
        guard let chatId = context.chatId else { return nil }
        let items = Item.allItems(in: chatId)
        var keyboard = [[InlineKeyboardButton]]()
        for item in items {
            var button = InlineKeyboardButton()
            button.text = "\(item.purchased ? "✅" : "◻️") \(item.name)"
            // A hack to left-align the text:
            button.text +=
                "                                              " +
                "                                              " +
            "                                              ."
            button.callback_data = "toggle \(item.itemId!)"
            keyboard.append([button])
        }
        
        var markup = InlineKeyboardMarkup()
        markup.inline_keyboard = keyboard
        return markup
    }
}
