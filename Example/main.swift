//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation

let environment = NSProcessInfo.processInfo().environment
guard let token = environment["TelegramExampleBotToken"] else {
    fatalError("Please set TelegramExampleBotToken environment variable")
}

let bot = TelegramBot(token: token)

class Controller {
    let bot: TelegramBot
    var message: Message { return bot.lastMessage }
    var startedInChatId = Set<Int>()
    var started: Bool {
        get { return startedInChatId.contains(message.chat.id) }
        set {
            switch newValue {
            case true: startedInChatId.insert(message.chat.id)
            case false: startedInChatId.remove(message.chat.id)
            }
        }
    }

    init(bot: TelegramBot) {
        self.bot = bot
    }
    
    func start() {
        guard !started else {
            bot.respondToGroup("@\(bot.username) already started.")
            return
        }
        started = true
        
        var startText: String
        if case .GroupChatType = message.chat {
            startText = "@\(bot.username) started. Use '/reverse some text' to reverse the text.\n"
        } else {
            startText = "@\(bot.username) started. Please type some text to reverse.\n"
        }
        startText += "To stop, type /stop"
        
        bot.respondToGroup(startText)
    }
    
    func stop() {
        guard started else {
            bot.respondToGroup("@\(bot.username) already stopped.")
            return
        }
        started = false
        bot.respondToGroup("@\(bot.username) stopped. To restart, type /start")
    }
    
    func help() {
        let helpText = "What can this bot do?\n" +
            "\n" +
            "This is a sample bot which reverses sentences. " +
            "If you want to invite friends, simply open the bot's profile " +
            "and use the 'Add to group' button to invite them.\n" +
            "\n" +
            "Send /start to begin reversing sentences.\n" +
            "Tell the bot to /stop when you're done.\n" +
            "In private chat simply type some text and it will be reversed.\n" +
            "In group chats use this command:\n" +
            "/reverse Sentence"
        
        bot.respondPrivately(helpText,
            groupText: "\(message.from.firstName), please find usage instructions in a personal message.")
    }
    
    func settings() {
        let settingsText = "Settings\n" +
            "\n" +
            "No settings are available for this bot."
        
        bot.respondPrivately(settingsText,
            groupText: "\(message.from.firstName), please find a list of settings in a personal message.")
    }

    func partialMatchHandler(unmatched: String, args: Arguments, path: Path) {
        bot.respondToGroup("❗ Part of your input was ignored: \(unmatched)")
    }

    func reverseText(args: Arguments) {
        guard started else { return }
        
        let text = args["text"].stringValue
        
        bot.respondToGroup(String(text.characters.reverse()))
    }
}

let controller = Controller(bot: bot)

let router = Router(partialMatchHandler: controller.partialMatchHandler)
router.addPath([Command("start")], controller.start)
router.addPath([Command("stop")], controller.stop)
router.addPath([Command("help")], controller.help)
router.addPath([Command("settings")], controller.settings)
router.addPath([Command("reverse", slash: .Required), RestOfString("text")],
    controller.reverseText)
// Default handler
router.addPath([RestOfString("text")], controller.reverseText)

print("Ready to accept commands")
while let command = bot.nextCommand() {
    print("--- updateId: \(bot.lastUpdate!.updateId)")
    print("message: \(bot.lastMessage.prettyPrint)")
    router.processString(command)
}
fatalError("Server stopped due to error: \(bot.lastError)")
