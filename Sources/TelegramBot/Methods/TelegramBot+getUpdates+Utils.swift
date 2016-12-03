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
        if nextOffset == nil || nextUpdateId > nextOffset! {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        return update
    }
}
