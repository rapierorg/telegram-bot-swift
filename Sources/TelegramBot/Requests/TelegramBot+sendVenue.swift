// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendVenueCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send information about a venue. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
	public func sendVenueSync(chat_id: Int64, latitude: Double, longitude: Double,
	                          title: String, address: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVenue"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude,
				 "title": title, "address": address]
		return requestSync("sendVenue", allParameters)
	}
	
	/// Send information about a venue. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
	public func sendVenueSync(chat_id: String, latitude: Double, longitude: Double,
	                          title: String, address: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendVenue"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude,
				 "title": title, "address": address]
		return requestSync("sendVenue", allParameters)
	}
	
	/// Send information about a venue. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
	public func sendVenueAsync(chat_id: Int64, latitude: Double, longitude: Double,
	                           title: String, address: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVenue"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude,
				 "title": title, "address": address]
		requestAsync("sendVenue", allParameters, queue: queue, completion: completion)
	}
	
	/// Send information about a venue. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
	public func sendVenueAsync(chat_id: String, latitude: Double, longitude: Double,
	                           title: String, address: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendVenue"] ?? [:] + parameters +
				["chat_id": chat_id, "latitude": latitude, "longitude": longitude,
				 "title": title, "address": address]
		requestAsync("sendVenue", allParameters, queue: queue, completion: completion)
	}
}
