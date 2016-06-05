// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	public static var unhandledErrorText = "❗ Error while performing the operation."

    public func reportErrorSync(chatId: Int64, text: String, errorDescription: String) {
		print("ERROR: \(errorDescription)")
		sendMessageSync(chatId: chatId, text: text)
    }
	
	public func reportErrorSync(chatId: Int64, errorDescription: String) {
		print("ERROR: \(errorDescription)")
		sendMessageSync(chatId: chatId, text: TelegramBot.unhandledErrorText)
	}
	
	public func reportErrorAsync(chatId: Int64?, text: String, errorDescription: String, completion: SendMessageCompletion? = nil) {
		print("ERROR: \(errorDescription)")
		guard let chatId = chatId else { return }
		sendMessageAsync(chatId: chatId, text: text, completion: completion)
	}
	
	public func reportErrorAsync(chatId: Int64?, errorDescription: String, completion: SendMessageCompletion? = nil) {
		print("ERROR: \(errorDescription)")
		guard let chatId = chatId else { return }
		sendMessageAsync(chatId: chatId, text: TelegramBot.unhandledErrorText, completion: completion)
	}
}
