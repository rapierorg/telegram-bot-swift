//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import GRDB

class MigrationController {
    static var migrator = DatabaseMigrator()
    
    static func migrate() throws {
        // Migrations run in order, once and only once. When a user upgrades the application, only non-applied migrations are run.
        
        // v1.0 database
        migrator.registerMigration("createTables") { db in
            try db.execute(
                "CREATE TABLE sessions (" +
                    "chat_id INTEGER PRIMARY KEY, " +
                    "router_name TEXT NOT NULL" +
                "); " +
                "CREATE TABLE items (" +
                    "item_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "chat_id INTEGER, " +
                    "name TEXT NOT NULL, " +
                    "purchased BOOLEAN NOT NULL, " +
                    "FOREIGN KEY(chat_id) REFERENCES sessions(chat_id) ON DELETE CASCADE" +
                "); " +
                "CREATE INDEX items_by_chat_idx ON items (chat_id, item_id); "

            )
        }
        
        // Migrations for future versions will be inserted here:
        //
        // // v2.0 database
        
        try migrator.migrate(DB.queue)
    }
}
