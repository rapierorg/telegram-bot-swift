// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias LeaveChatCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Leave a group, supergroup or channel. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatSync(chat_id: Int64,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["leaveChat"] ?? [:] + parameters +
			["chat_id": chat_id]
		return requestSync("leaveChat", allParameters)
	}
	
	/// Leave a group, supergroup or channel. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatSync(chat_id: String,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["leaveChat"] ?? [:] + parameters +
			["chat_id": chat_id]
		return requestSync("leaveChat", allParameters)
	}
	
	/// Leave a group, supergroup or channel. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatAsync(chat_id: Int64,
	                         parameters: [String: Any?] = [:],
	                         queue: dispatch_queue_t = dispatch_get_main_queue(),
	                         completion: LeaveChatCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["leaveChat"] ?? [:] + parameters +
			["chat_id": chat_id]
		requestAsync("leaveChat", allParameters, queue: queue, completion: completion)
	}
	
	/// Leave a group, supergroup or channel. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatAsync(chat_id: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: LeaveChatCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["leaveChat"] ?? [:] + parameters +
			["chat_id": chat_id]
		requestAsync("leaveChat", allParameters, queue: queue, completion: completion)
	}
}
