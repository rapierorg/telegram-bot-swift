//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBotSDK
import GRDB

class Session: Record {
    var chatId: Int64
    var routerName: String

    override class var databaseTableName: String {
        return "sessions"
    }
    
    required init(row: Row) {
        chatId = row["chat_id"]
        routerName = row["router_name"]
        super.init(row: row)
    }

    init(chatId: Int64) {
        self.chatId = chatId
        self.routerName = "main"
        super.init()
    }
    
    static func session(for chatId: Int64) throws -> Session {
        let session: Session = try DB.queue.inDatabase { db in
            var session = try Session.fetchOne(db, key: chatId)
            if session == nil {
                session = Session(chatId: chatId)
                try session?.insert(db)
            }
            return session!
        }
        return session
    }
    
    func save() throws {
        try DB.queue.inDatabase { db in
            try self.save(db)
        }
    }
}
