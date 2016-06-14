// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	typealias GetUserProfilePhotosCompletion = (result: UserProfilePhotos?, error: DataTaskError?)->()
	
	/// Get a list of profile pictures for a user. Blocking version.
	/// - Returns: `UserProfilePhotos` object. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getuserprofilephotos>
	public func getUserProfilePhotosSync(_ parameters: [String: Any?] = [:]) -> UserProfilePhotos? {
		return requestSync("getUserProfilePhotos", defaultParameters["getUserProfilePhotos"], parameters)
	}
	
	/// Get a list of profile pictures for a user. Asynchronous version.
	/// - Returns: `UserProfilePhotos` object. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getuserprofilephotos>
	private func getMeAsync(_ parameters: [String: Any?] = [:],
	                        queue: DispatchQueue = DispatchQueue.main,
	                        completion: GetUserProfilePhotosCompletion? = nil) {
		requestAsync("getUserProfilePhotos",
		             defaultParameters["getUserProfilePhotos"], parameters,
		             queue: queue, completion: completion)
	}
}
