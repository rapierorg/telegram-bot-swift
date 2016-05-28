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
                    lastUpdate = nil
                    return nil
                }
            } while updates!.isEmpty // Timeout, retry
            unprocessedUpdates = updates!
        }
        
        guard let update = unprocessedUpdates.first else {
            lastUpdate = nil
            return nil
        }
        
        let nextUpdateId = update.update_id + 1
        if nextOffset == nil || nextUpdateId > nextOffset {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        lastUpdate = update
        return update
    }
    
	/// Receive incoming updates using long polling. Blocking version.
	/// - Returns: Array of updates on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getupdates>
    public func getUpdatesSync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil) -> [Update]? {
		let allParameters: [String: Any?] = [
			"offset": offset,
		    "limit": limit,
		    "timeout": timeout
		]
		return requestSync("getUpdates", allParameters)
    }
    
	/// Receive incoming updates using long polling. Asynchronous version.
	/// - Returns: Array of updates on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: <https://core.telegram.org/bots/api#getupdates>
    public func getUpdatesAsync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil, queue: dispatch_queue_t = dispatch_get_main_queue(), completion: GetUpdatesCompletion? = nil) {
        let allParameters: [String: Any?] = [
            "offset": offset,
            "limit": limit,
            "timeout": timeout
        ]
		requestAsync("getUpdates", allParameters, queue: queue, completion: completion)
    }
}
