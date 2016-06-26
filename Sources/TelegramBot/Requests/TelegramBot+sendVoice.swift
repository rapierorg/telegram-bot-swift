// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendVoiceCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	@discardableResult
	public func sendVoiceSync(chat_id: ChatId, voice: String,
	                          _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendVoice", defaultParameters["sendVoice"], parameters,
		                   ["chat_id": chat_id, "voice": voice])
	}
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	public func sendVoiceAsync(chat_id: ChatId, voice: String,
	                           _ parameters: [String: Any?] = [:],
	                           queue: DispatchQueue = DispatchQueue.main,
	                           completion: SendMessageCompletion? = nil) {
		requestAsync("sendVoice", defaultParameters["sendVoice"], parameters,
		             ["chat_id": chat_id, "voice": voice],
		             queue: queue, completion: completion)
	}
}
