// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetChatAdministratorsCompletion = (result: [ChatMember]?, error: DataTaskError?)->()
	
	/// Get a list of administrators in a chat. Blocking version.
	/// - Returns: Array of ChatMember objects that contains information about all chat administrators except other bots on success. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatadministrators>
	public func getChatAdministratorsSync(chatId: Int64,
	                                      parameters: [String: Any?] = [:]) -> [ChatMember]? {
		let allParameters: [String: Any?] =
			defaultParameters["getChatAdministrators"] ?? [:] + parameters +
				["chat_id": chatId]
		return requestSync("getChatAdministrators", allParameters)
	}
	
	/// Get a list of administrators in a chat. Asynchronous version.
	/// - Returns: Array of ChatMember objects that contains information about all chat administrators except other bots on success. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getchatadministrators>
	public func getChatAdministratorsAsync(chatId: Int64,
	                                       parameters: [String: Any?] = [:],
	                                       queue: dispatch_queue_t = dispatch_get_main_queue(),
	                                       completion: GetChatCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getChatAdministrators"] ?? [:] + parameters +
				["chat_id": chatId]
		requestAsync("getChatAdministrators", allParameters, queue: queue, completion: completion)
	}
}
