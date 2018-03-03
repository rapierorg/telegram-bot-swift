// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import XCTest
@testable import TelegramBotSDK

class BlockingServerTests: XCTestCase {

    var token: String!

    override func setUp() {
        token = readToken(from: "TEST_BOT_TOKEN")
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func _testServer() {
        let bot = TelegramBot(token: token)

        while let update = bot.nextUpdateSync() {
            print("--- update: \(update.debugDescription)")
            if let message = update.message, let text = message.text, let chatId = message.from?.id {
                if text == "Hello" {
                    bot.sendMessageAsync(chat_id: chatId, text: "How are you?")
                }
            }
        }
        print("Server stopped due to error: \(bot.lastError)")
    }
    
    static var allTests : [(String, (BlockingServerTests) -> () throws -> Void)] {
        return [
            //("testExample", testExample),
        ]
    }
}

