// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	public typealias GetUpdatesCompletion = (result: [Update]?, error: DataTaskError?)->()

    /// Returns next unprocessed update from Telegram.
    ///
    /// If no more updates are available in local queue, the method blocks while
    /// trying to fetch more from the server.
    ///
    /// - Returns: `Update` object. Nil on error, in which case details can be
    ///            obtained using `lastError` property.
    public func nextUpdateSync() -> Update? {
        if unprocessedUpdates.isEmpty {
            var updates: [Update]?
            repeat {
                updates = getUpdatesSync(offset: nextOffset,
                    limit: defaultUpdatesLimit,
                    timeout: defaultUpdatesTimeout)
                if updates == nil {
                    // Error, report to caller
                    return nil
                }
            } while updates!.isEmpty // Timeout, retry
            unprocessedUpdates = updates!
        }
        
        guard let update = unprocessedUpdates.first else {
            return nil
        }
        
        let nextUpdateId = update.update_id + 1
        if nextOffset == nil || nextUpdateId > nextOffset {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        return update
    }
    
	/// Receive incoming updates using long polling. Blocking version.
	/// - Returns: Array of updates on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getupdates>
    public func getUpdatesSync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil,
                               _ parameters: [String: Any?] = [:]) -> [Update]? {
		return requestSync("getUpdates", defaultParameters["getUpdates"], parameters,
		                   ["offset": offset, "limit": limit, "timeout": timeout])
    }
    
	/// Receive incoming updates using long polling. Asynchronous version.
	/// - Returns: Array of updates on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getupdates>
    public func getUpdatesAsync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil,
                                _ parameters: [String: Any?] = [:],
                                queue: DispatchQueue = DispatchQueue.main, completion: GetUpdatesCompletion? = nil) {
		requestAsync("getUpdates", defaultParameters["getUpdates"], parameters,
		             ["offset": offset, "limit": limit, "timeout": timeout],
		             queue: queue, completion: completion)
    }
}
