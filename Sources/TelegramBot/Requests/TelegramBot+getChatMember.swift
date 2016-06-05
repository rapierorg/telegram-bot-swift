// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatMemberCompletion = (result: ChatMember?, error: DataTaskError?)->()
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(chatId: Int64, userId: Int64,
	                               parameters: [String: Any?] = [:]) -> ChatMember? {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chatId, "user_id": userId]
		return requestSync("getChatMember", allParameters)
	}
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(channelUserName: String, userId: Int64,
	                               parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": channelUserName, "user_id": userId]
		return requestSync("getChatMember", allParameters)
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(chatId: Int64, userId: Int64,
	                                parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: GetChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": chatId, "user_id": userId]
		requestAsync("getChatMember", allParameters, queue: queue, completion: completion)
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(channelUserName: String, userId: Int64,
	                                parameters: [String: Any?] = [:],
	                                queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                completion: GetChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getChatMember"] ?? [:] + parameters +
				["chat_id": channelUserName, "user_id": userId]
		requestAsync("getChatMember", allParameters, queue: queue, completion: completion)
	}
}
