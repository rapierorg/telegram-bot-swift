// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {	
	typealias SendMessageCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send text message. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func sendMessageSync(chatId: Int, text: String,
	                        parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendMessage"] ?? [:] + parameters +
			["chat_id": chatId, "text": text]
		return requestSync("sendMessage", allParameters)
	}
	
    /// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
	public func sendMessageAsync(chatId: Int, text: String,
	                        parameters: [String: Any?] = [:],
	                        queue: dispatch_queue_t = dispatch_get_main_queue(),
	                        completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendMessage"] ?? [:] + parameters +
			["chat_id": chatId, "text": text]
		requestAsync("sendMessage", allParameters, queue: queue, completion: completion)
    }
}
