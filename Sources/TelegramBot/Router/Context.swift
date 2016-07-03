// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Context {
	typealias T = Context
		
	public let bot: TelegramBot
	public let update: Update
	/// `update.message` shortcut. Make sure that the message exists before using it,
	/// otherwise it will be empty. For paths supported by Router the message is guaranteed to exist.
	public var message: Message? {
        return update.message ??
            update.edited_message ??
            update.callback_query?.message
    }

    /// Command starts with slash (useful if you want to skip commands not starting with slash in group chats)
    public let slash: Bool
    public let command: String
    public let args: Arguments

	public var privateChat: Bool {
        guard let message = message else { return false }
        return message.chat.type == .private_chat
    }
	public var chatId: Int64? { return message?.chat.id ??
        update.callback_query?.message?.chat.id
    }
	public var fromId: Int64? {
        return update.message?.from?.id ??
            (update.edited_message?.from?.id ??
            update.callback_query?.from.id)
    }
    public var properties: [String: AnyObject]
	
    init(bot: TelegramBot, update: Update, scanner: Scanner, command: String, startsWithSlash: Bool, properties: [String: AnyObject] = [:]) {
		self.bot = bot
		self.update = update
        self.slash = startsWithSlash
        self.command = command
        self.args = Arguments(scanner: scanner)
        self.properties = properties
	}
    
    /// Sends a message to current chat.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
    @discardableResult
    public func respondSync(_ text: String,
                            parse_mode: String? = nil,
                            disable_web_page_preview: Bool? = nil,
                            disable_notification: Bool? = nil,
                            reply_to_message_id: Int? = nil,
                            reply_markup: ReplyMarkup? = nil,
                            _ parameters: [String: Any?] = [:]) -> Message? {
        guard let chat_id = chatId else {
            assertionFailure("respondSync() used when update.message is nil")
            bot.lastError = nil
            return nil
        }
        return bot.requestSync("sendMessage", bot.defaultParameters["sendMessage"], parameters, [
            "chat_id": chat_id,
            "text": text,
            "parse_mode": parse_mode,
            "disable_web_page_preview": disable_web_page_preview,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup])
    }
    
    /// Sends a message to current chat.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func respondAsync(_ text: String,
	                         parse_mode: String? = nil,
	                         disable_web_page_preview: Bool? = nil,
	                         disable_notification: Bool? = nil,
	                         reply_to_message_id: Int? = nil,
	                         reply_markup: ReplyMarkup? = nil,
	                         _ parameters: [String: Any?] = [:],
	                         queue: DispatchQueue = .main,
	                         completion: TelegramBot.SendMessageCompletion? = nil) {
        guard let chat_id = chatId else {
            assertionFailure("respondAsync() used when update.message is nil")
            return
        }
        return bot.requestAsync("sendMessage", bot.defaultParameters["sendMessage"], parameters, [
            "chat_id": chat_id,
            "text": text,
            "parse_mode": parse_mode,
            "disable_web_page_preview": disable_web_page_preview,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup],
                            queue: queue, completion: completion)
	}
	
    /// Respond privately also sending a message to a group.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	@discardableResult
	public func respondPrivatelySync(_ userText: String, groupText: String) -> (userMessage: Message?, groupMessage: Message?) {
		var userMessage: Message?
		if let fromId = fromId {
			userMessage = bot.sendMessageSync(chat_id: fromId, text: userText)
		}
		var groupMessage: Message? = nil
		if !privateChat {
            if let chatId = chatId {
                groupMessage = bot.sendMessageSync(chat_id: chatId, text: groupText)
            } else {
                assertionFailure("respondPrivatelySync() used when update.message is nil")
                bot.lastError = nil
            }
		}
		return (userMessage, groupMessage)
	}
	
    /// Respond privately also sending a message to a group.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func respondPrivatelyAsync(_ userText: String, groupText: String,
	                                  onDidSendToUser userCompletion: TelegramBot.SendMessageCompletion? = nil,
	                                  onDidSendToGroup groupCompletion: TelegramBot.SendMessageCompletion? = nil) {
		if let fromId = fromId {
			bot.sendMessageAsync(chat_id: fromId, text: userText, completion: userCompletion)
		}
		if !privateChat {
            if let chatId = chatId {
                bot.sendMessageAsync(chat_id: chatId, text: groupText, completion: groupCompletion)
            } else {
                assertionFailure("respondPrivatelyAsync() used when update.message is nil")
            }
		}
	}
	
    @discardableResult
	public func reportErrorSync(text: String, errorDescription: String) -> Message? {
        guard let chatId = chatId else {
            assertionFailure("reportErrorSync() used when update.message is nil")
            bot.lastError = nil
            return nil
        }
        return bot.reportErrorSync(chatId: chatId, text: text, errorDescription: errorDescription)
	}

    @discardableResult
	public func reportErrorSync(errorDescription: String) -> Message? {
        guard let chatId = chatId else {
            assertionFailure("reportErrorSync() used when update.message is nil")
            bot.lastError = nil
            return nil
        }
		return bot.reportErrorSync(chatId: chatId, errorDescription: errorDescription)
	}

	public func reportErrorAsync(text: String, errorDescription: String, completion: TelegramBot.SendMessageCompletion? = nil) {
        guard let chatId = chatId else {
            assertionFailure("reportErrorAsync() used when update.message is nil")
            return
        }
		bot.reportErrorAsync(chatId: chatId, text: text, errorDescription: errorDescription, completion: completion)
	}
	
	public func reportErrorAsync(errorDescription: String, completion: TelegramBot.SendMessageCompletion? = nil) {
        guard let chatId = chatId else {
            assertionFailure("reportErrorAsync() used when update.message is nil")
            return
        }
		bot.reportErrorAsync(chatId: chatId, errorDescription: errorDescription, completion: completion)
	}
}
