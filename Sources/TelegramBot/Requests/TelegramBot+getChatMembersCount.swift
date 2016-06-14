// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatMembersCountCompletion = (result: Int?, error: DataTaskError?)->()
	
	/// Get the number of members in a chat. Blocking version.
	/// - Returns: Int on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmemberscount>
	public func getChatMembersCountSync(chat_id: Int64,
	                                    _ parameters: [String: Any?] = [:]) -> Int? {
		return requestSync("getChatMembersCount", defaultParameters["getChatMembersCount"], parameters,
		                   ["chat_id": chat_id])
	}
	
	/// Get the number of members in a chat. Blocking version.
	/// - Returns: Int on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmemberscount>
	public func getChatMembersCountSync(chat_id: String,
	                                    _ parameters: [String: Any?] = [:]) -> Int? {
		return requestSync("getChatMembersCount", defaultParameters["getChatMembersCount"], parameters,
		                   ["chat_id": chat_id])
	}
	
	/// Get the number of members in a chat. Asynchronous version.
	/// - Returns: Int on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmemberscount>
	public func getChatMemberAsync(chat_id: Int64,
	                               _ parameters: [String: Any?] = [:],
	                               queue: DispatchQueue = DispatchQueue.main,
	                               completion: GetChatMemberCompletion? = nil) {
		requestAsync("getChatMembersCount", defaultParameters["getChatMembersCount"], parameters,
		             ["chat_id": chat_id],
		             queue: queue, completion: completion)
	}
	
	/// Get the number of members in a chat. Asynchronous version.
	/// - Returns: Int on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatmemberscount>
	public func getChatMemberAsync(chat_id: String,
	                               _ parameters: [String: Any?] = [:],
	                               queue: DispatchQueue = DispatchQueue.main,
	                               completion: GetChatMemberCompletion? = nil) {
		requestAsync("getChatMembersCount", defaultParameters["getChatMembersCount"], parameters,
		             ["chat_id": chat_id],
		             queue: queue, completion: completion)
	}
}
