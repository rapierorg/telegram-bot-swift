// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	public typealias GetMeCompletion = (result: User?, error: DataTaskError?)->()
	
	/// A simple method for testing your bot's auth token. Requires no parameters. Blocking version.
	/// - Returns: Basic information about the bot in form of a `User` object.
	///            Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getme>
	public func getMeSync(_ parameters: [String: Any?] = [:]) -> User? {
		return requestSync("getMe", defaultParameters["getMe"], parameters)
	}
	
    /// A simple method for testing your bot's auth token. Requires no parameters. Asynchronous version.
    /// - Returns: Basic information about the bot in form of a `User` object.
    ///            Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getme>
	public func getMeAsync(_ parameters: [String: Any?] = [:],
	                       queue: dispatch_queue_t = dispatch_get_main_queue(),
	                       completion: GetMeCompletion? = nil) {
		requestAsync("getMe",
		             defaultParameters["getMe"], parameters,
		             queue: queue, completion: completion)
    }
}
