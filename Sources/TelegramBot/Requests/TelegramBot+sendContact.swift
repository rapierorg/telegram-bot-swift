// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendContactCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send phone contacts. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactSync(chatId: Int64, phoneNumber: String, firstName: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendContact"] ?? [:] + parameters +
				["chat_id": chatId, "phone_number": phoneNumber, "first_name": firstName]
		return requestSync("sendContact", allParameters)
	}
	
	/// Send phone contacts. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactSync(channelUserName: String, phoneNumber: String, firstName: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendContact"] ?? [:] + parameters +
				["chat_id": channelUserName, "phone_number": phoneNumber, "first_name": firstName]
		return requestSync("sendContact", allParameters)
	}
	
	/// Send phone contacts. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactAsync(chatId: Int64, phoneNumber: String, firstName: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendContact"] ?? [:] + parameters +
				["chat_id": chatId, "phone_number": phoneNumber, "first_name": firstName]
		requestAsync("sendContact", allParameters, queue: queue, completion: completion)
	}
	
	/// Send phone contacts. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendcontact>
	public func sendContactAsync(channelUserName: String, phoneNumber: String, firstName: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendContact"] ?? [:] + parameters +
				["chat_id": channelUserName, "phone_number": phoneNumber, "first_name": firstName]
		requestAsync("sendContact", allParameters, queue: queue, completion: completion)
	}
}
