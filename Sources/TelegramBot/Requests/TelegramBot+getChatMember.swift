// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatMemberCompletion = (result: ChatMember?, error: DataTaskError?)->()
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(chat_id: Int64, user_id: Int64,
	                               parameters: [String: Any?] = [:]) -> ChatMember? {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		return requestSync("getChatMember", allParameters)
	}
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(chat_id: String, user_id: Int64,
	                               parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		return requestSync("getChatMember", allParameters)
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(chat_id: Int64, user_id: Int64,
	                                parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: GetChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		requestAsync("getChatMember", allParameters, queue: queue, completion: completion)
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(chat_id: String, user_id: Int64,
	                                parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: GetChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		requestAsync("getChatMember", allParameters, queue: queue, completion: completion)
	}
}
