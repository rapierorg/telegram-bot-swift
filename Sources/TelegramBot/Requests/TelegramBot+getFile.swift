// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetFileCompletion = (result: File?, error: DataTaskError?)->()
	
	/// Get basic info about a file and prepare it for downloading. Blocking version.
	/// - Returns: File object on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileSync(fileId: String,
	                        parameters: [String: Any?] = [:]) -> File? {
		let allParameters: [String: Any?] =
			defaultParameters["getFile"] ?? [:] + parameters +
			["file_id": fileId]
		return syncRequest("getFile", allParameters)
	}
	
	/// Get basic info about a file and prepare it for downloading. Asynchronous version.
	/// - Returns: File object on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileAsync(fileId: String,
	                         parameters: [String: Any?] = [:],
	                         queue: dispatch_queue_t = dispatch_get_main_queue(),
	                         completion: GetFileCompletion? = nil) {
		let allParameters: [String: Any?] =
			defaultParameters["getFile"] ?? [:] + parameters +
			["file_id": fileId]
		asyncRequest("getFile", allParameters, queue: queue, completion: completion)
	}
}
