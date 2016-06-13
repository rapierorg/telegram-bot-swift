// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatCompletion = (result: Chat?, error: DataTaskError?)->()
	
	/// Get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Blocking version.
	/// - Returns: Chat object on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchat>
	public func getChatSync(chat_id: Int64,
	                        _ parameters: [String: Any?] = [:]) -> Chat? {
		return requestSync("getChat", defaultParameters["getChat"], parameters,
		                   ["chat_id": chat_id])
	}
	
	/// Get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Asynchronous version.
	/// - Returns: Chat object on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchat>
	public func getChatAsync(chat_id: Int64,
	                         _ parameters: [String: Any?] = [:],
	                         queue: dispatch_queue_t = dispatch_get_main_queue(),
	                         completion: GetChatCompletion? = nil) {
		requestAsync("getChat", defaultParameters["getChat"], parameters,
		             ["chat_id": chat_id],
		             queue: queue, completion: completion)
	}
}
