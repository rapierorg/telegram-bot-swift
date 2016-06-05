// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendVoiceCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	public func sendVoiceSync(chatId: Int64, voice: String,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVoice"] ?? [:] + parameters +
				["chat_id": chatId, "voice": voice]
		return requestSync("sendVoice", allParameters)
	}
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	public func sendVoiceSync(channelUserName: String, voice: String,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVoice"] ?? [:] + parameters +
				["chat_id": channelUserName, "voice": voice]
		return requestSync("sendVoice", allParameters)
	}
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	public func sendVoiceAsync(chatId: Int64, voice: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVoice"] ?? [:] + parameters +
				["chat_id": chatId, "voice": voice]
		requestAsync("sendVoice", allParameters, queue: queue, completion: completion)
	}
	
	/// Send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvoice>
	public func sendVoiceAsync(channelUserName: String, voice: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVoice"] ?? [:] + parameters +
				["chat_id": channelUserName, "voice": voice]
		requestAsync("sendVoice", allParameters, queue: queue, completion: completion)
	}
}
