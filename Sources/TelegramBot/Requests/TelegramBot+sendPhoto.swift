// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendPhotoCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send photo. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	public func sendPhotoSync(chatId: Int64, photo: String,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendPhoto"] ?? [:] + parameters +
				["chat_id": chatId, "photo": photo]
		return requestSync("sendPhoto", allParameters)
	}

	/// Send photo. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	public func sendPhotoSync(channelUserName: String, photo: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendPhoto"] ?? [:] + parameters +
				["chat_id": channelUserName, "photo": photo]
		return requestSync("sendPhoto", allParameters)
	}
	
	/// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	public func sendMessageAsync(chatId: Int64, photo: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendPhoto"] ?? [:] + parameters +
				["chat_id": chatId, "photo": photo]
		requestAsync("sendPhoto", allParameters, queue: queue, completion: completion)
	}
	
	/// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	public func sendMessageAsync(channelUserName: String, photo: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendPhoto"] ?? [:] + parameters +
				["chat_id": channelUserName, "photo": photo]
		requestAsync("sendPhoto", allParameters, queue: queue, completion: completion)
	}
}
