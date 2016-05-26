// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias GetFileCompletion = (file: File?, error: DataTaskError?)->()
	
	/// Get basic info about a file and prepare it for downloading. Blocking version.
	/// - Returns: File object on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileSync(fileId: String,
	                            parameters: [String: Any?] = [:]) -> File? {
		var result: File!
		let sem = dispatch_semaphore_create(0)
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		getFileAsync(fileId: fileId, parameters: parameters, queue: queue) {
			message, error in
			result = message
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		return result
	}
	
	/// Get basic info about a file and prepare it for downloading. Asynchronous version.
	/// - Returns: File object on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getfile>
	public func getFileAsync(fileId: String,
	                             parameters: [String: Any?] = [:],
	                             queue: dispatch_queue_t = dispatch_get_main_queue(),
	                             completion: GetFileCompletion? = nil) {
		var allParameters: [String: Any?] = [
		                                    	"file_id": fileId
		]
		allParameters += defaultParameters["getFile"]
		allParameters += parameters
		startDataTaskForEndpoint("getFile", parameters: allParameters) {
			result, error in
			var file: File?
			if error == nil {
				file = File(result)
			}
			dispatch_async(queue) {
				completion?(file: file, error: error)
			}
		}
	}
}
