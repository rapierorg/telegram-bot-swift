// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendStickerCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send .webp stickers. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
	public func sendStickerSync(chat_id: Int64, sticker: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendSticker"] ?? [:] + parameters +
				["chat_id": chat_id, "sticker": sticker]
		return requestSync("sendSticker", allParameters)
	}
	
	/// Send .webp stickers. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
	public func sendStickerSync(chat_id: String, sticker: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendSticker"] ?? [:] + parameters +
				["chat_id": chat_id, "sticker": sticker]
		return requestSync("sendSticker", allParameters)
	}
	
	/// Send .webp stickers. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
	public func sendStickerAsync(chat_id: Int64, sticker: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendSticker"] ?? [:] + parameters +
				["chat_id": chat_id, "sticker": sticker]
		requestAsync("sendSticker", allParameters, queue: queue, completion: completion)
	}
	
	/// Send .webp stickers. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
	public func sendStickerAsync(chat_id: String, sticker: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendSticker"] ?? [:] + parameters +
				["chat_id": chat_id, "sticker": sticker]
		requestAsync("sendSticker", allParameters, queue: queue, completion: completion)
	}
}
