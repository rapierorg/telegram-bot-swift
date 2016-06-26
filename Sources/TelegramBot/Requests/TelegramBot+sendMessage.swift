// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {	
	typealias SendMessageCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send text message. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	@discardableResult
	public func sendMessageSync(chat_id: ChatId, text: String,
	                            _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendMessage", defaultParameters["sendMessage"], parameters,
		                   ["chat_id": chat_id, "text": text])
	}

    /// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func sendMessageAsync(chat_id: ChatId, text: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: DispatchQueue = DispatchQueue.main,
	                             completion: SendMessageCompletion? = nil) {
		requestAsync("sendMessage", defaultParameters["sendMessage"], parameters,
		             ["chat_id": chat_id, "text": text],
		             queue: queue, completion: completion)
    }
}
