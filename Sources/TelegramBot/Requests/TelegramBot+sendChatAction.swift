// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

// TODO: add enum for action

public extension TelegramBot {
	typealias SendChatActionCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Tells the user that something is happening on the bot's side. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	@discardableResult
	public func sendChatActionSync(chat_id: Int64, action: String,
	                               _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		                   ["chat_id": chat_id, "action": action])
	}
	
	/// Tells the user that something is happening on the bot's side. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	@discardableResult
	public func sendChatActionSync(chat_id: String, action: String,
	                               _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		                   ["chat_id": chat_id, "action": action])
	}
	
	/// Tells the user that something is happening on the bot's side. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	public func sendChatActionAsync(chat_id: Int64, action: String,
	                                _ parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: SendChatActionCompletion? = nil) {
		requestAsync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		             ["chat_id": chat_id, "action": action],
		             queue: queue, completion: completion)
	}
	
	/// Tells the user that something is happening on the bot's side. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	public func sendChatActionAsync(chat_id: String, action: String,
	                                _ parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: SendChatActionCompletion? = nil) {
		requestAsync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		             ["chat_id": chat_id, "action": action],
		             queue: queue, completion: completion)
	}
}
