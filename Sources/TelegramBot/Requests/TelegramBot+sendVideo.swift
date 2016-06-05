// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendVideoCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoSync(chat_id: Int64, video: String,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVideo"] ?? [:] + parameters +
				["chat_id": chat_id, "video": video]
		return requestSync("sendVideo", allParameters)
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoSync(chat_id: String, video: String,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVideo"] ?? [:] + parameters +
				["chat_id": chat_id, "video": video]
		return requestSync("sendVideo", allParameters)
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoAsync(chat_id: Int64, video: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVideo"] ?? [:] + parameters +
				["chat_id": chat_id, "video": video]
		requestAsync("sendVideo", allParameters, queue: queue, completion: completion)
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoAsync(chat_id: String, video: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVideo"] ?? [:] + parameters +
				["chat_id": chat_id, "video": video]
		requestAsync("sendVideo", allParameters, queue: queue, completion: completion)
	}
}
