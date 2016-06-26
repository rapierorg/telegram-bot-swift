// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendPhotoCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send photo. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	@discardableResult
	public func sendPhotoSync(chat_id: ChatId, photo: Photo,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendPhoto", defaultParameters["sendPhoto"], parameters,
		                   ["chat_id": chat_id, "photo": photo])
	}
	
	/// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendphoto>
	public func sendPhotoAsync(chat_id: ChatId, photo: Photo,
	                           _ parameters: [String: Any?] = [:],
	                           queue: DispatchQueue = DispatchQueue.main,
	                           completion: SendMessageCompletion? = nil) {
		requestAsync("sendPhoto", defaultParameters["sendPhoto"], parameters,
		             ["chat_id": chat_id, "photo": photo],
		             queue: queue, completion: completion)
	}	
}
