//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import GRDB

class Item: Record {
    var itemId: Int64?
    var chatId: Int64
    var name: String
    var purchased: Bool
    
    override class func databaseTableName() -> String {
        return "items"
    }
    
    required init(row: Row) {
        itemId = row.value(named: "item_id")
        chatId = row.value(named: "chat_id")
        name = row.value(named: "name")
        purchased = row.value(named: "purchased")
        super.init(row: row)
    }
    
    init(name: String, chatId: Int64) {
        self.chatId = chatId
        self.name = name
        self.purchased = false
        super.init()
    }
    
    override var persistentDictionary: [String: DatabaseValueConvertible?] {
        return ["item_id": itemId,
                "chat_id": chatId,
                "name": name,
                "purchased": purchased]
    }
    
    override func didInsert(with rowID: Int64, for column: String?) {
        itemId = rowID
    }
    
    static func add(name: String, chatId: Int64) throws {
        let item = Item(name: name, chatId: chatId)
        try DB.queue.inDatabase { db in
            try item.insert(db)
        }
    }
    
    static func allItems(in chatId: Int64) -> [Item] {
        return DB.queue.inDatabase { db in
            Item.fetchAll(db, "SELECT * FROM items WHERE chat_id = ?", arguments: [chatId])
        }
    }
    
    static func item(itemId: Int64, from chatId: Int64) throws -> Item? {
        let item = DB.queue.inDatabase { db in
            Item.fetchOne(db, "SELECT * FROM items WHERE chat_id = ? AND item_id = ?", arguments: [chatId, itemId])
        }
        return item
    }
    
    static func deletePurchased(in chatId: Int64) throws {
        try DB.queue.inDatabase { db in
            try db.execute("DELETE FROM items WHERE chat_id = ? AND purchased = 1", arguments: [chatId])
        }
    }
    
    func save() throws {
        try DB.queue.inDatabase { db in
            try self.save(db)
        }
    }
}
