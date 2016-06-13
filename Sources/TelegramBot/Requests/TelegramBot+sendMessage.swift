// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {	
	typealias SendMessageCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send text message. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	@discardableResult
	public func sendMessageSync(chat_id: Int64, text: String,
	                            _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendMessage", defaultParameters["sendMessage"], parameters,
		                   ["chat_id": chat_id, "text": text])
	}

	/// Send text message. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	@discardableResult
	public func sendMessageSync(_ chat_id: Int64, _ text: String,
	                            _ parameters: [String: Any?] = [:]) -> Message? {
		return sendMessageSync(chat_id: chat_id, text: text, parameters)
	}

    /// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func sendMessageAsync(chat_id: Int64, text: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		requestAsync("sendMessage", defaultParameters["sendMessage"], parameters,
		             ["chat_id": chat_id, "text": text],
		             queue: queue, completion: completion)
    }
	
	/// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func sendMessageAsync(_ chat_id: Int64, _ text: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		sendMessageAsync(chat_id: chat_id, text: text, parameters, queue: queue, completion: completion)
	}
}
