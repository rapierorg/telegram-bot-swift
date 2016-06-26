// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias LeaveChatCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Leave a group, supergroup or channel. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	@discardableResult
	public func leaveChatSync(chat_id: ChatId,
	                          _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("leaveChat", defaultParameters["leaveChat"], parameters,
		                   ["chat_id": chat_id])
	}
	
	/// Leave a group, supergroup or channel. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatAsync(chat_id: ChatId,
	                           _ parameters: [String: Any?] = [:],
	                           queue: DispatchQueue = DispatchQueue.main,
	                           completion: LeaveChatCompletion? = nil) {
		requestAsync("leaveChat", defaultParameters["leaveChat"], parameters,
		             ["chat_id": chat_id],
		             queue: queue, completion: completion)
	}
}
