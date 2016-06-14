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
	                             _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendDocument", defaultParameters["sendDocument"], parameters,
		                   ["chat_id": chat_id, "document": document])
	}
	
	/// Send general files. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	@discardableResult
	public func sendDocumentSync(chat_id: String, document: String,
	                             _ parameters: [String: Any?] = [:]) -> Message? {
		return requestSync("sendDocument", defaultParameters["sendDocument"], parameters,
		                   ["chat_id": chat_id, "document": document])
	}
	
	/// Send general files. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	public func sendDocumentAsync(chat_id: Int64, document: String,
	                              _ parameters: [String: Any?] = [:],
	                              queue: DispatchQueue = DispatchQueue.main,
	                              completion: SendMessageCompletion? = nil) {
		requestAsync("sendDocument", defaultParameters["sendDocument"], parameters,
		             ["chat_id": chat_id, "document": document],
		             queue: queue, completion: completion)
	}
	
	/// Send general files. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#senddocument>
	public func sendDocumentAsync(chat_id: String, document: String,
	                              _ parameters: [String: Any?] = [:],
	                              queue: DispatchQueue = DispatchQueue.main,
	                              completion: SendMessageCompletion? = nil) {
		requestAsync("sendDocument", defaultParameters["sendDocument"], parameters,
		             ["chat_id": chat_id, "document": document],
		             queue: queue, completion: completion)
	}
}
