// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendContactCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send phone contacts. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	@discardableResult
	public func sendContactSync(chat_id: Int64, phone_number: String, first_name: String,
	                            _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendContact", defaultParameters["sendContact"], parameters,
		                   ["chat_id": chat_id, "phone_number": phone_number, "first_name": first_name])
	}
	
	/// Send phone contacts. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	@discardableResult
	public func sendContactSync(chat_id: String, phone_number: String, first_name: String,
	                            _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendContact", defaultParameters["sendContact"], parameters,
		                   ["chat_id": chat_id, "phone_number": phone_number, "first_name": first_name])
	}
	
	/// Send phone contacts. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactAsync(chat_id: Int64, phone_number: String, first_name: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: DispatchQueue = DispatchQueue.main,
	                             completion: SendMessageCompletion? = nil) {
		requestAsync("sendContact", defaultParameters["sendContact"], parameters,
		             ["chat_id": chat_id, "phone_number": phone_number, "first_name": first_name],
		             queue: queue, completion: completion)
	}
	
	/// Send phone contacts. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactAsync(chat_id: String, phone_number: String, first_name: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: DispatchQueue = DispatchQueue.main,
	                             completion: SendMessageCompletion? = nil) {
		requestAsync("sendContact", defaultParameters["sendContact"], parameters,
		             ["chat_id": chat_id, "phone_number": phone_number, "first_name": first_name],
		             queue: queue, completion: completion)
	}
}
