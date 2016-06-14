// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendVideoCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	@discardableResult
	public func sendVideoSync(chat_id: Int64, video: String,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendVideo", defaultParameters["sendVideo"], parameters,
		                   ["chat_id": chat_id, "video": video])
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	@discardableResult
	public func sendVideoSync(chat_id: String, video: String,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendVideo", defaultParameters["sendVideo"], parameters,
		                   ["chat_id": chat_id, "video": video])
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoAsync(chat_id: Int64, video: String,
	                           _ parameters: [String: Any?] = [:],
	                           queue: DispatchQueue = DispatchQueue.main,
	                           completion: SendMessageCompletion? = nil) {
		requestAsync("sendVideo", defaultParameters["sendVideo"], parameters,
		             ["chat_id": chat_id, "video": video],
		             queue: queue, completion: completion)
	}
	
	/// Send video files, Telegram clients support mp4 videos (other formats may be sent as Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvideo>
	public func sendVideoAsync(chat_id: String, video: String,
	                             _ parameters: [String: Any?] = [:],
	                             queue: DispatchQueue = DispatchQueue.main,
	                             completion: SendMessageCompletion? = nil) {
		requestAsync("sendVideo", defaultParameters["sendVideo"], parameters,
		             ["chat_id": chat_id, "video": video],
		             queue: queue, completion: completion)
	}
}
