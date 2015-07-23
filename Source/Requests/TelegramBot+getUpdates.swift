//
// TelegramBot+getStatus.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension TelegramBot {

    /// Returns next unprocessed update from Telegram.
    ///
    /// If no more updates are available in local queue, the method blocks while
    /// trying to fetch more from the server.
    ///
    /// - Returns: `Update` object. Null on error, in which case details can be
    ///            obtained using `lastError` property.
    func nextUpdate() -> Update? {
        if unprocessedUpdates.isEmpty {
            guard let updates = getUpdatesWithOffset(nextOffset,
                    limit: defaultUpdatesLimit,
                    timeout: defaultUpdatesTimeout)
            else {
                return nil
            }
            unprocessedUpdates = updates
        }
        
        guard let update = unprocessedUpdates.first else {
            return nil
        }
        
        if nextOffset == nil || update.updateId > nextOffset {
            nextOffset = update.updateId
        }
        unprocessedUpdates.removeAtIndex(0)
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
    func getUpdatesWithOffset(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil, completion: (updates: [Update]?, error: DataTaskError?)->()) {
        getUpdatesWithOffset(offset, limit: limit, timeout: timeout, queue: queue, completion: completion)
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
    func getUpdatesWithOffset(offset: Int? = nil, limit: Int? = nil, timeout: Int? = nil) -> [Update]? {
        var result: [Update]!
        let sem = dispatch_semaphore_create(0)
        getUpdatesWithOffset(offset, limit: limit, timeout: timeout, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                updates, error in
            result = updates
            self.lastError = error
            dispatch_semaphore_signal(sem)
        }
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }
    
    private func getUpdatesWithOffset(offset: Int?, limit: Int?, timeout: Int?, queue: dispatch_queue_t, completion: (updates: [Update]?, error: DataTaskError?)->()) {
        let parameters: [String: Any?] = [
            "offset": offset,
            "limit": limit,
            "timeout": timeout
        ]
        startDataTaskForEndpoint("getUpdates", parameters: parameters) {
                (result, var error) in
            var updates = [Update]()
            if error == nil {
                updates.reserveCapacity(result.count)
                for updateJson in result.arrayValue {
                    if let update = Update(json: updateJson) {
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
