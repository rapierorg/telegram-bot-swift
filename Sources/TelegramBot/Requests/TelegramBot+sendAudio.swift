// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendAudioCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .mp3 format. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendaudio>
	@discardableResult
	public func sendAudioSync(chat_id: Int64, audio: String,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendAudio", defaultParameters["sendAudio"], parameters,
		                   ["chat_id": chat_id, "audio": audio])
	}
	
	/// Send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .mp3 format. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendaudio>
	@discardableResult
	public func sendAudioSync(chat_id: String, audio: String,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendAudio", defaultParameters["sendAudio"], parameters,
		                   ["chat_id": chat_id, "audio": audio])
	}
	
	/// Send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .mp3 format. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendaudio>
	public func sendAudioAsync(chat_id: Int64, audio: String,
	                           _ parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		requestAsync("sendAudio", defaultParameters["sendAudio"], parameters,
		             ["chat_id": chat_id, "audio": audio],
		             queue: queue, completion: completion)
	}
	
	/// Send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .mp3 format. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendaudio>
	public func sendAudioAsync(chat_id: String, audio: String,
	                           _ parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		requestAsync("sendAudio", defaultParameters["sendAudio"], parameters,
		             ["chat_id": chat_id, "audio": audio],
		             queue: queue, completion: completion)
	}
}
