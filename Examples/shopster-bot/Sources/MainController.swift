//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

class MainController {
    typealias T = MainController
    
    struct Commands {
        static let start = "start"
        static let help = "help"
        static let add = ["Add Item", "add"]
        static let delete = ["Delete Item", "delete"]
        static let list = ["List Items", "list"]
    }
    
    let bot: TelegramBot
    let router: Router
    
    init(bot: TelegramBot) {
        self.bot = bot
        self.router = Router(bot: bot)
        
        router[Commands.start  ] = onStart
        router[Commands.help   ] = onHelp
        
        router[Commands.add    ] = onAdd
        
        router[Commands.delete ] = onDelete
        router[Commands.list   ] = onList
    }
    
    func onStart(context: Context) -> Bool {
        var markup = ReplyKeyboardMarkup()
        markup.keyboardStrings = [
            [ Commands.add[0], Commands.delete[0] ],
            [ Commands.list[0] ]
        ]
        context.respondAsync("Please choose an option.", ["reply_markup": markup])
        return true
    }
    
    func onHelp(context: Context) -> Bool {
        context.respondAsync("Usage:\n" +
            "/add name - add a new item to list"
        )
        return true
    }
    
    func onAdd(context: Context) -> Bool {
        let item = context.args.scanRestOfString()
        context.respondAsync("Added: \(item)")
        return true
    }
    
    func onDelete(context: Context) -> Bool {
        return true
    }
    
    func onList(context: Context) -> Bool {
        return true
    }
}
