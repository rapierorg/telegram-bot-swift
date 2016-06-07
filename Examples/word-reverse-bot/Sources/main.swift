//
// main.swift
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBot

let token = readToken("WORD_REVERSE_BOT_TOKEN")

class Controller {
    let bot: TelegramBot
    var startedInChatId = Set<Int64>()
	
	func started(in chatId: Int64) -> Bool {
		return startedInChatId.contains(chatId)
 	}

    init(bot: TelegramBot) {
        self.bot = bot
    }
    
	func start(context: Context) -> Bool {
		guard !started(in: context.chatId) else {
            context.respondAsync("@\(bot.username) already started.")
            return true
        }
        startedInChatId.insert(context.chatId)
        
        var startText: String
        if !context.privateChat {
            startText = "@\(bot.username) started. Use '/reverse some text' to reverse the text.\n"
        } else {
            startText = "@\(bot.username) started. Please type some text to reverse.\n"
        }
        startText += "To stop, type /stop"
        
        context.respondAsync(startText)
		return true
    }
    
	func stop(context: Context) -> Bool {
		guard started(in: context.chatId) else {
            context.respondAsync("@\(bot.username) already stopped.")
            return true
        }
		startedInChatId.remove(context.chatId)
		
        context.respondSync("@\(bot.username) stopped. To restart, type /start")
		return true
    }
    
	func help(context: Context) -> Bool {
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
        
        context.respondPrivatelyAsync(helpText,
            groupText: "\(context.message.from.first_name), please find usage instructions in a personal message.")
		return true
    }
    
	func settings(context: Context) -> Bool {
        let settingsText = "Settings\n" +
            "\n" +
            "No settings are available for this bot."
        
        context.respondPrivatelyAsync(settingsText,
            groupText: "\(context.message.from.first_name), please find a list of settings in a personal message.")
		return true
    }

    func partialMatchHandler(context: Context) -> Bool {
        context.respondAsync("❗ Part of your input was ignored: \(context.args.scanRestOfString())")
		return true
    }

    func reverseText(context: Context) -> Bool {
		guard started(in: context.chatId) else { return false }
		
        let text = context.args.scanRestOfString()
	
        context.respondAsync(String(text.characters.reversed()))
		return true
    }
    
    func reverseWords(context: Context) -> Bool {
		guard started(in: context.chatId) else { return false }
		
        let words = context.args.scanWords()
        switch words.isEmpty {
        case true: context.respondAsync("Please specify some words to reverse.")
		case false: context.respondAsync(words.reversed().joined(separator: " "))
        }
		return true
    }
}

let bot = TelegramBot(token: token)
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
// If command has unprocessed arguments, report them:
router.partialMatch = controller.partialMatchHandler

print("Ready to accept commands")
while let update = bot.nextUpdateSync() {
	print("--- update: \(update)")
	
	try router.process(update: update)
}
fatalError("Server stopped due to error: \(bot.lastError)")

