//
// TelegramBot+getStatus.swift
//
// Copyright (c) 2016 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension TelegramBot {
	public typealias GetUpdatesCompletion = (updates: [Update]?, error: DataTaskError?)->()

    /// Returns next unprocessed update from Telegram.
    ///
    /// If no more updates are available in local queue, the method blocks while
    /// trying to fetch more from the server.
    ///
    /// - Returns: `Update` object. Nil on error, in which case details can be
    ///            obtained using `lastError` property.
    public func nextUpdateSync() -> /*NS*/Update? {
        if unprocessedUpdates.isEmpty {
            var updates: [/*NS*/Update]?
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
        
        let nextUpdateId = update.updateId + 1
        if nextOffset == nil || nextUpdateId > nextOffset {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        lastUpdate = update
        return update
    }
    
	/// Receive incoming updates using long polling. Blocking version.
	/// - Returns: Array of updates on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: https://core.telegram.org/bots/api#getupdates
    public func getUpdatesSync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil) -> [/*NS*/Update]? {
        var result: [/*NS*/Update]!
        let sem = dispatch_semaphore_create(0)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        getUpdatesAsync(offset: offset, limit: limit, timeout: timeout, queue: queue) {
                updates, error in
            result = updates
            self.lastError = error
            dispatch_semaphore_signal(sem)
        }
		NSRunLoop.current().waitForSemaphore(sem)
        //dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }
    
	/// Receive incoming updates using long polling. Asynchronous version.
	/// - Returns: Array of updates on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: https://core.telegram.org/bots/api#getupdates
    public func getUpdatesAsync(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil, queue: dispatch_queue_t = dispatch_get_main_queue(), completion: GetUpdatesCompletion? = nil) {
        let parameters: [String: Any?] = [
            "offset": offset,
            "limit": limit,
            "timeout": timeout
        ]
        startDataTaskForEndpoint("getUpdates", parameters: parameters) {
                result, error in
			var error = error
            var updates = [/*NS*/Update]()
            if error == nil {
                updates.reserveCapacity(result.count)
                for updateJson in result.arrayValue {
                    if let update = /*NS*/Update(json: updateJson) {
                        updates.append(update)
                    } else {
                        error = .ResultParseError(json: result)
                        break
                    }
                }
            }
            dispatch_async(queue) {
                completion?(updates: error == nil ? updates : nil,
                    error: error)
            }
        }
    }
}
