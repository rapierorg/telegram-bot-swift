// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatAdministratorsCompletion = (result: [ChatMember]?, error: DataTaskError?)->()
	
	/// Get a list of administrators in a chat. Blocking version.
	/// - Returns: Array of ChatMember objects that contains information about all chat administrators except other bots on success. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatadministrators>
	public func getChatAdministratorsSync(chat_id: ChatId,
	                                      _ parameters: [String: Any?] = [:]) -> [ChatMember]? {
		return requestSync("getChatAdministrators", defaultParameters["getChatAdministrators"], parameters,
		                   ["chat_id": chat_id])
	}
	
	/// Get a list of administrators in a chat. Asynchronous version.
	/// - Returns: Array of ChatMember objects that contains information about all chat administrators except other bots on success. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatadministrators>
	public func getChatAdministratorsAsync(chat_id: ChatId,
	                                       _ parameters: [String: Any?] = [:],
	                                       queue: DispatchQueue = DispatchQueue.main,
	                                       completion: GetChatCompletion? = nil) {
		requestAsync("getChatAdministrators", defaultParameters["getChatAdministrators"], parameters,
		             ["chat_id": chat_id],
		             queue: queue, completion: completion)
	}
}
