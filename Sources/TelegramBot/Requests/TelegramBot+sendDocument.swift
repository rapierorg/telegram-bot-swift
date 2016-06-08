// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

// TODO: add InputFile

public extension TelegramBot {
	typealias SendDocumentCompletion = (result: Message?, error: DataTaskError?)->()
	
	/// Send general files. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	@discardableResult
	public func sendDocumentSync(chat_id: Int64, document: String,
	                             parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendDocument"] ?? [:] + parameters +
				["chat_id": chat_id, "document": document]
		return requestSync("sendDocument", allParameters)
	}
	
	/// Send general files. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	@discardableResult
	public func sendDocumentSync(chat_id: String, document: String,
	                          parameters: [String: Any?] = [:]) -> Message? {
		let allParameters: [String: Any?] =
			defaultParameters["sendDocument"] ?? [:] + parameters +
				["chat_id": chat_id, "document": document]
		return requestSync("sendDocument", allParameters)
	}
	
	/// Send general files. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	public func sendDocumentAsync(chat_id: Int64, document: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendDocument"] ?? [:] + parameters +
				["chat_id": chat_id, "document": document]
		requestAsync("sendDocument", allParameters, queue: queue, completion: completion)
	}
	
	/// Send general files. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	public func sendDocumentAsync(chat_id: String, document: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: SendMessageCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["sendDocument"] ?? [:] + parameters +
				["chat_id": chat_id, "document": document]
		requestAsync("sendDocument", allParameters, queue: queue, completion: completion)
	}
}
