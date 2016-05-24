//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let token = readToken("WORD_REVERSE_BOT_TOKEN")

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
            bot.respondAsync("@\(bot.username) already started.")
            return
        }
        started = true
        
        var startText: String
        if message.chat.type != .privateChat {
            startText = "@\(bot.username) started. Use '/reverse some text' to reverse the text.\n"
        } else {
            startText = "@\(bot.username) started. Please type some text to reverse.\n"
        }
        startText += "To stop, type /stop"
        
        bot.respondAsync(startText)
    }
    
    func stop() {
        guard started else {
            bot.respondAsync("@\(bot.username) already stopped.")
            return
        }
        started = false
        bot.respondSync("@\(bot.username) stopped. To restart, type /start")
    }
    
    func help() {
        let helpText = "What can this bot do?\n" +
            "\n" +
            "This is a sample bot which reverses sentences or words. " +
            "If you want to invite friends, simply open the bot's profile " +
            "and use the 'Add to group' button to invite them.\n" +
            "\n" +
            "Send /start to begin reversing sentences.\n" +
            "Tell the bot to /stop when you're done.\n" +
            "\n" +
            "In private chat simply type some text and it will be reversed.\n" +
            "In group chats use this command:\n" +
            "/reverse Sentence\n" +
            "\n" +
            "To reverse words, use /word_reverse word1 word2 word3..."
        
        bot.respondPrivatelyAsync(helpText,
            groupText: "\(message.from.first_name), please find usage instructions in a personal message.")
    }
    
    func settings() {
        let settingsText = "Settings\n" +
            "\n" +
            "No settings are available for this bot."
        
        bot.respondPrivatelyAsync(settingsText,
            groupText: "\(message.from.first_name), please find a list of settings in a personal message.")
    }

    func partialMatchHandler(args: Arguments) {
        bot.respondSync("❗ Part of your input was ignored: \(args.scanRestOfString())")
    }

    func reverseText(args: Arguments) -> Bool {
        guard started else { return false }
        
        let text = args.scanRestOfString()
	
        bot.respondAsync(String(text.characters.reversed()))
		return true
    }
    
    func reverseWords(args: Arguments) -> Bool {
        guard started else { return false }
        
        let words = args.scanWords()
        switch words.isEmpty {
        case true: bot.respondAsync("Please specify some words to reverse.")
		case false: bot.respondAsync(words.reversed().joined(separator: " "))
        }
		return true
    }
}

let controller = Controller(bot: bot)

let router = Router(bot: bot)
router["start"] = controller.start
router["stop"] = controller.stop
router["help"] = controller.help
router["settings"] = controller.settings
router["reverse", slash: .Required] = controller.reverseText
router["word_reverse"] = controller.reverseWords
// Default handler
router.unknownCommand = controller.reverseText

print("Ready to accept commands")
while let message = bot.nextMessageSync() {
	print("--- update_id: \(bot.lastUpdate!.update_id)")
	print("message: \(message.debugDescription)")
	print("command: \(bot.lastCommand.unwrapOptional)")
	
	if let command = bot.lastCommand {
		try router.process(command)
	}
}
fatalError("Server stopped due to error: \(bot.lastError)")
