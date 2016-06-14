// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatMemberCompletion = (result: ChatMember?, error: DataTaskError?)->()
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(chat_id: Int64, user_id: Int64,
	                              _ parameters: [String: Any?] = [:]) -> ChatMember? {
		return requestSync("getChatMember", defaultParameters["getChatMember"], parameters,
		                   ["chat_id": chat_id, "user_id": user_id])
	}
	
	/// Get information about a member of a chat. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberSync(chat_id: String, user_id: Int64,
	                              _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("getChatMember", defaultParameters["getChatMember"], parameters,
		                   ["chat_id": chat_id, "user_id": user_id])
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(chat_id: Int64, user_id: Int64,
	                               _ parameters: [String: Any?] = [:],
	                               queue: DispatchQueue = DispatchQueue.main,
	                               completion: GetChatMemberCompletion? = nil) {
		requestAsync("getChatMember", defaultParameters["getChatMember"], parameters,
		             ["chat_id": chat_id, "user_id": user_id],
		             queue: queue, completion: completion)
	}
	
	/// Get information about a member of a chat. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmember>
	public func getChatMemberAsync(chat_id: String, user_id: Int64,
	                                _ parameters: [String: Any?] = [:],
	                                queue: DispatchQueue = DispatchQueue.main,
	                                completion: GetChatMemberCompletion? = nil) {
		requestAsync("getChatMember", defaultParameters["getChatMember"], parameters,
		             ["chat_id": chat_id, "user_id": user_id],
		             queue: queue, completion: completion)
	}
}
