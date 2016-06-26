// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias KickChatMemberCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	@discardableResult
	public func kickChatMemberSync(chat_id: ChatId, user_id: Int64,
	                               _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("kickChatMember", defaultParameters["kickChatMember"], parameters,
		                   ["chat_id": chat_id, "user_id": user_id])
	}
		
	/// Kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#kickchatmember>
	public func kickChatMemberAsync(chat_id: ChatId, user_id: Int64,
	                                _ parameters: [String: Any?] = [:],
	                                queue: DispatchQueue = DispatchQueue.main,
	                                completion: KickChatMemberCompletion? = nil) {
		requestAsync("kickChatMember", defaultParameters["kickChatMember"], parameters,
		             ["chat_id": chat_id, "user_id": user_id],
		             queue: queue, completion: completion)
	}
}
