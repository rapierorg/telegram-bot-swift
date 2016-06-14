// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias UnbanChatMemberCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	@discardableResult
	public func unbanChatMemberSync(chat_id: Int64, user_id: Int64,
	                                _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("unbanChatMember", defaultParameters["unbanChatMember"], parameters,
		                   ["chat_id": chat_id, "user_id": user_id])
	}
	
	/// Unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	@discardableResult
	public func unbanChatMemberSync(chat_id: String, user_id: Int64,
	                                _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("unbanChatMember", defaultParameters["unbanChatMember"], parameters,
		                   ["chat_id": chat_id, "user_id": user_id])
	}
	
	/// Unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func unbanChatMemberAsync(chat_id: Int64, user_id: Int64,
	                                 _ parameters: [String: Any?] = [:],
	                                 queue: DispatchQueue = DispatchQueue.main,
	                                 completion: UnbanChatMemberCompletion? = nil) {
		requestAsync("unbanChatMember", defaultParameters["unbanChatMember"], parameters,
		             ["chat_id": chat_id, "user_id": user_id],
		             queue: queue, completion: completion)
	}
	
	/// Unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func unbanChatMemberAsync(chat_id: String, user_id: Int64,
	                                 _ parameters: [String: Any?] = [:],
	                                 queue: DispatchQueue = DispatchQueue.main,
	                                 completion: UnbanChatMemberCompletion? = nil) {
		requestAsync("unbanChatMember", defaultParameters["unbanChatMember"], parameters,
		             ["chat_id": chat_id, "user_id": user_id],
		             queue: queue, completion: completion)
	}
}
