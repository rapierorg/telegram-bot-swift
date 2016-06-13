// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension TelegramBot {
	typealias AnswerCallbackQueryCompletion = (result: Bool?, error: DataTaskError?)->()
	
	/// Send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. Blocking version.
	/// - Returns: true on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#answercallbackquery>
	@discardableResult
	public func answerCallbackQuerySync(callback_query_id: String,
	                                    _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("answerCallbackQuery", defaultParameters["answerCallbackQuery"], parameters,
			["callback_query_id": callback_query_id])
	}
	
	/// Send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. Asynchronous version.
	/// - Returns: true on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#answercallbackquery>
	public func answerCallbackQueryAsync(callback_query_id: String,
	                                     _ parameters: [String: Any?] = [:],
	                                     queue: dispatch_queue_t = dispatch_get_main_queue(),
	                           completion: AnswerCallbackQueryCompletion? = nil) {
		requestAsync("answerCallbackQuery", defaultParameters["answerCallbackQuery"], parameters,
		             ["callback_query_id": callback_query_id],
		             queue: queue, completion: completion)
	}
}
