//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBotSDK
import GRDB

class DB {
    static let queue: DatabaseQueue = {
        var config = Configuration()
        config.busyMode = .timeout(10) // Wait 10 seconds before throwing SQLITE_BUSY error
        config.defaultTransactionKind = .deferred
        config.trace = { print($0) }     // Prints all SQL statements
        
        do {
            return try DatabaseQueue(path: "db.sqlite", configuration: config)
        } catch {
            fatalError("Unable to open database: \(error)")
        }
    }()
}
