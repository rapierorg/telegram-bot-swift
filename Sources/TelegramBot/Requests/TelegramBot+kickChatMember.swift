// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias KickChatMemberCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberSync(chatId: Int64, userId: Int64,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chatId, "user_id": userId]
		return requestSync("kickChatMember", allParameters)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberSync(channelUserName: String, userId: Int64,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": channelUserName, "user_id": userId]
		return requestSync("kickChatMember", allParameters)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberAsync(chatId: Int64, userId: Int64,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: KickChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": chatId, "user_id": userId]
		requestAsync("kickChatMember", allParameters, queue: queue, completion: completion)
	}
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberAsync(channelUserName: String, userId: Int64,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: KickChatMemberCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["kickChatMember"] ?? [:] + parameters +
				["chat_id": channelUserName, "user_id": userId]
		requestAsync("kickChatMember", allParameters, queue: queue, completion: completion)
	}
}
