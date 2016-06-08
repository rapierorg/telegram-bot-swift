// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendLocationCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send point on the map. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendlocation>
	@discardableResult
	public func sendLocationSync(chat_id: Int64, latitude: Double, longitude: Double,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendLocation"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude]
		return requestSync("sendLocation", allParameters)
	}
	
	/// Send point on the map. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendlocation>
	@discardableResult
	public func sendLocationSync(chat_id: String, latitude: Double, longitude: Double,
	                            parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendLocation"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude]
		return requestSync("sendLocation", allParameters)
	}
	
	/// Send point on the map. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendlocation>
	public func sendLocationAsync(chat_id: Int64, latitude: Double, longitude: Double,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendLocation"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude]
		requestAsync("sendLocation", allParameters, queue: queue, completion: completion)
	}
	
	/// Send point on the map. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendlocation>
	public func sendLocationAsync(chat_id: String, latitude: Double, longitude: Double,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendLocation"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude]
		requestAsync("sendLocation", allParameters, queue: queue, completion: completion)
	}
}
