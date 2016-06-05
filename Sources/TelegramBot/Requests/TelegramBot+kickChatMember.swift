// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias KickChatMemberCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberSync(chat_id: Int64, user_id: Int64,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		return requestSync("kickChatMember", allParameters)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberSync(chat_id: String, user_id: Int64,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		return requestSync("kickChatMember", allParameters)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberAsync(chat_id: Int64, user_id: Int64,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: KickChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		requestAsync("kickChatMember", allParameters, queue: queue, completion: completion)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberAsync(chat_id: String, user_id: Int64,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: KickChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chat_id, "user_id": user_id]
		requestAsync("kickChatMember", allParameters, queue: queue, completion: completion)
	}
}
