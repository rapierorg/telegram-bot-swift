//
// Context.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation
import Dispatch

public class Context {
	typealias T = Context
		
	public let bot: TelegramBot
	public let update: Update
	/// `update.message` shortcut. Make sure that the message exists before using it,
	/// otherwise it will be empty. For paths supported by Router the message is guaranteed to exist.
	public var message: Message? {
        return update.message ??
            update.editedMessage ??
            update.callbackQuery?.message
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
        update.callbackQuery?.message?.chat.id
    }
	public var fromId: Int64? {
        return update.message?.from?.id ??
            (update.editedMessage?.from?.id ??
            update.callbackQuery?.from.id)
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
                            parseMode: String? = nil,
                            disableWebPagePreview: Bool? = nil,
                            disableNotification: Bool? = nil,
                            replyToMessageId: Int? = nil,
                            replyMarkup: ReplyMarkup? = nil,
                            _ parameters: [String: Any?] = [:]) -> Message? {
        guard let chatId = chatId else {
            assertionFailure("respondSync() used when update.message is nil")
            bot.lastError = nil
            return nil
        }
        return bot.requestSync("sendMessage", bot.defaultParameters["sendMessage"], parameters, [
            "chat_id": chatId,
            "text": text,
            "parse_mode": parseMode,
            "disable_web_page_preview": disableWebPagePreview,
            "disable_notification": disableNotification,
            "reply_to_message_id": replyToMessageId,
            "reply_markup": replyMarkup])
    }
    
    /// Sends a message to current chat.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func respondAsync(_ text: String,
	                         parseMode: String? = nil,
	                         disableWebPagePreview: Bool? = nil,
	                         disableNotification: Bool? = nil,
	                         replyToMessageId: Int? = nil,
	                         replyMarkup: ReplyMarkup? = nil,
	                         _ parameters: [String: Any?] = [:],
	                         queue: DispatchQueue = .main,
	                         completion: TelegramBot.SendMessageCompletion? = nil) {
        guard let chatId = chatId else {
            assertionFailure("respondAsync() used when update.message is nil")
            return
        }
        return bot.requestAsync("sendMessage", bot.defaultParameters["sendMessage"], parameters, [
            "chat_id": chatId,
            "text": text,
            "parse_mode": parseMode,
            "disable_web_page_preview": disableWebPagePreview,
            "disable_notification": disableNotification,
            "reply_to_message_id": replyToMessageId,
            "reply_markup": replyMarkup],
                            queue: queue, completion: completion)
	}
	
    /// Respond privately also sending a message to a group.
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	@discardableResult
	public func respondPrivatelySync(_ userText: String, groupText: String) -> (userMessage: Message?, groupMessage: Message?) {
		var userMessage: Message?
		if let fromId = fromId {
			userMessage = bot.sendMessageSync(chatId: fromId, text: userText)
		}
		var groupMessage: Message? = nil
		if !privateChat {
            if let chatId = chatId {
                groupMessage = bot.sendMessageSync(chatId: chatId, text: groupText)
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
			bot.sendMessageAsync(chatId: fromId, text: userText, completion: userCompletion)
		}
		if !privateChat {
            if let chatId = chatId {
                bot.sendMessageAsync(chatId: chatId, text: groupText, completion: groupCompletion)
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
