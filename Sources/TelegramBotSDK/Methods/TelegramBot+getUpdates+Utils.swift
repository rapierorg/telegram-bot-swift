//
// TelegramBot+getUpdates+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation
import CCurl

extension TelegramBot {
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
            var retryCount = 0
            while true {
                updates = getUpdatesSync(offset: nextOffset,
                    limit: defaultUpdatesLimit,
                    timeout: defaultUpdatesTimeout)
                if updates == nil {
                    // Retry on temporary problems
                    if autoReconnect,
                        let error = lastError,
                        case .libcurlError(let code, _) = error
                    {
                        switch code {
                        case CURLE_COULDNT_RESOLVE_PROXY, CURLE_COULDNT_RESOLVE_HOST, CURLE_COULDNT_CONNECT, CURLE_OPERATION_TIMEDOUT, CURLE_SSL_CONNECT_ERROR, CURLE_SEND_ERROR, CURLE_RECV_ERROR:
                            let delay = reconnectDelay(retryCount)
                            retryCount += 1
                            if delay == 0.0 {
                                logger("Reconnect attempt \(retryCount), will retry at once")
                            } else {
                                logger("Reconnect attempt \(retryCount), will retry after \(delay) sec")
                                wait(seconds: delay)
                            }
                            continue
                        default:
                            break
                        }
                    }
                    // Unrecoverable error, report to caller
                    return nil
                }
                if let updates = updates, !updates.isEmpty {
                    break
                }
                // else try again
            }
            unprocessedUpdates = updates!
        }
        
        guard let update = unprocessedUpdates.first else {
            return nil
        }
        
        let nextUpdateId = update.update_id + 1
        if nextOffset == nil || nextUpdateId > nextOffset! {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        return update
    }
}
