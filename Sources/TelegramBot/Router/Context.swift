// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Context {
	typealias T = Context
	
	public let bot: TelegramBot
	public let message: Message
	public let args: Arguments

	public var privateChat: Bool { return message.chat.type == .privateChat }
	public var chatId: Int { return message.chat.id }
	
	init(bot: TelegramBot, message: Message, scanner: NSScanner, command: String) {
		self.bot = bot
		self.message = message
		self.args = Arguments(scanner: scanner, command: command)
	}
	
	public func respondAsync(_ text: String,
	                         parameters: [String: Any?] = [:],
	                         queue: dispatch_queue_t = dispatch_get_main_queue(),
	                         completion: TelegramBot.SendMessageCompletion? = nil) {
		bot.sendMessageAsync(chatId: chatId, text: text, parameters: parameters, queue: queue, completion: completion)
	}
	
	public func respondSync(_ text: String,
	                        parameters: [String: Any?] = [:]) -> Message? {
		return bot.sendMessageSync(chatId: chatId, text: text, parameters: parameters)
	}
	
	public func reportErrorSync(text: String, errorDescription: String) {
		bot.reportErrorSync(chatId: chatId, text: text, errorDescription: errorDescription)
	}

	public func reportErrorSync(errorDescription: String) {
		bot.reportErrorSync(chatId: chatId, errorDescription: errorDescription)
	}

	public func reportErrorAsync(text: String, errorDescription: String, completion: TelegramBot.SendMessageCompletion? = nil) {
		bot.reportErrorAsync(chatId: chatId, text: text, errorDescription: errorDescription, completion: completion)
	}
	
	public func reportErrorAsync(errorDescription: String, completion: TelegramBot.SendMessageCompletion? = nil) {
		bot.reportErrorAsync(chatId: chatId, errorDescription: errorDescription, completion: completion)
	}
}
