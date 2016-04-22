//
// TelegramBot+getStatus.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension TelegramBot {

    /// Returns next unprocessed update from Telegram.
    ///
    /// If no more updates are available in local queue, the method blocks while
    /// trying to fetch more from the server.
    ///
    /// - Returns: `Update` object. Null on error, in which case details can be
    ///            obtained using `lastError` property.
    public func nextUpdate() -> /*NS*/Update? {
        if unprocessedUpdates.isEmpty {
            var updates: [/*NS*/Update]?
            repeat {
                updates = getUpdates(offset: nextOffset,
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
    
    /// Receive incoming updates using long polling.
    ///
    /// This is an asynchronous version of the method,
    /// a blocking one is also available.
    ///
    /// - Parameter offset: Identifier of the first update to be returned. If nil,
    ///                    updates starting with the earliest unconfirmed update
    ///                    are returned.
    /// - Parameter limit: Limits the number of updates to be retrieved.
    ///                    Values between 1—100 are accepted. If nil, defaults
    ///                    to 100.
    /// - Parameter timeout: Timeout in seconds for long polling. If nil, short
    ///                    polling will be used.
    /// - Parameter completion: Completion handler which will be called on main
    ///                    queue by default. The queue can be overridden by
    ///                    setting `queue` property of TelegramBot.
    /// - Returns: Array of `Update` objects. Null on error, in which case `error`
    ///                    contains the details.
    /// - SeeAlso: `func getUpdatesWithLimit(timeout:) -> [Update]?`
    public func getUpdates(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil, completion: (updates: [/*NS*/Update]?, error: /*NS*/DataTaskError?)->()) {
        getUpdates(offset: offset, limit: limit, timeout: timeout, queue: queue, completion: completion)
    }
    
    /// Receive incoming updates using long polling.
    ///
    /// This is a blocking version of the method,
    /// an asynchronous one is also available.
    ///
    /// - Parameter offset: Identifier of the first update to be returned. If nil,
    ///                    updates starting with the earliest unconfirmed update
    ///                    are returned.
    /// - Parameter limit: Limits the number of updates to be retrieved.
    ///                    Values between 1—100 are accepted. If nil, defaults
    ///                    to 100.
    /// - Parameter timeout: Timeout in seconds for long polling. If nil, short
    ///                    polling will be used.
    /// - Returns: Array of `Update` objects. Null on error, in which case details
    ///            can be obtained using `lastError` property.
    /// - SeeAlso: `func getUpdatesWithLimit(timeout:completion:)->()`
    public func getUpdates(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil) -> [/*NS*/Update]? {
        var result: [/*NS*/Update]!
        let sem = dispatch_semaphore_create(0)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        getUpdates(offset: offset, limit: limit, timeout: timeout, queue: queue) {
                updates, error in
            result = updates
            self.lastError = error
            dispatch_semaphore_signal(sem)
        }
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }
    
    private func getUpdates(offset: Int?, limit: Int?, timeout: Int?, queue: dispatch_queue_t, completion: (updates: [/*NS*/Update]?, error: /*NS*/DataTaskError?)->()) {
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
                completion(updates: error == nil ? updates : nil,
                    error: error)
            }
        }
    }
}
