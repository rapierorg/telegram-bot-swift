// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetFileCompletion = (result: File?, error: DataTaskError?)->()
	
	/// Get basic info about a file and prepare it for downloading. Blocking version.
	/// - Returns: File object on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileSync(file_id: String,
	                        _ parameters: [String: Any?] = [:]) -> File? {
		return requestSync("getFile", defaultParameters["getFile"], parameters,
		                   ["file_id": file_id])
	}
	
	/// Get basic info about a file and prepare it for downloading. Asynchronous version.
	/// - Returns: File object on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileAsync(file_id: String,
	                         _ parameters: [String: Any?] = [:],
	                         queue: DispatchQueue = DispatchQueue.main,
	                         completion: GetFileCompletion? = nil) {
		requestAsync("getFile", defaultParameters["getFile"], parameters,
		             ["file_id": file_id],
		             queue: queue, completion: completion)
	}
}
