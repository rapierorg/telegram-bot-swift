// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias LeaveChatCompletion = (success: Bool, error: DataTaskError?)->()
	
	/// Leave a group, supergroup or channel. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatSync(chatId: Int,
	                        parameters: [String: Any?] = [:]) -> Bool? {
		var result: Bool!
		let sem = dispatch_semaphore_create(0)
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		leaveChatAsync(chatId: chatId, parameters: parameters, queue: queue) {
			success, error in
			result = success
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		return result
	}
	
	/// Leave a group, supergroup or channel. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatSync(channelUserName: String,
	                          parameters: [String: Any?] = [:]) -> Bool? {
		var result: Bool!
		let sem = dispatch_semaphore_create(0)
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		leaveChatAsync(channelUserName: channelUserName, parameters: parameters, queue: queue) {
			success, error in
			result = success
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		return result
	}
	
	/// Leave a group, supergroup or channel. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatAsync(chatId: Int,
	                         parameters: [String: Any?] = [:],
	                         queue: dispatch_queue_t = dispatch_get_main_queue(),
	                         completion: LeaveChatCompletion? = nil) {
		var allParameters: [String: Any?] = [
			"chat_id": chatId
		]
		allParameters += defaultParameters["leaveChat"]
		allParameters += parameters
		startDataTaskForEndpoint("leaveChat", parameters: allParameters) {
			success, error in
			var result = false
			if error == nil {
				result = result.boolValue
			}
			dispatch_async(queue) {
				completion?(success: result, error: error)
			}
		}
	}
	
	/// Leave a group, supergroup or channel. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#leavechat>
	public func leaveChatAsync(channelUserName: String,
	                           parameters: [String: Any?] = [:],
	                           queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: LeaveChatCompletion? = nil) {
		var allParameters: [String: Any?] = [
			"chat_id": channelUserName
		]
		allParameters += defaultParameters["leaveChat"]
		allParameters += parameters
		startDataTaskForEndpoint("leaveChat", parameters: allParameters) {
			success, error in
			var result = false
			if error == nil {
				result = result.boolValue
			}
			dispatch_async(queue) {
				completion?(success: result, error: error)
			}
		}
	}
}
