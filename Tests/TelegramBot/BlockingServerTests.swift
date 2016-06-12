//
// BlockingServerTests.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import XCTest
@testable import TelegramBot

class BlockingServerTests: XCTestCase {

    var token: String!

    override func setUp() {
        token = readToken("TEST_BOT_TOKEN")
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func _testServer() {
        let bot = TelegramBot(token: token)

        while let update = bot.nextUpdateSync() {
            print("--- update: \(update.debugDescription)")
            if let message = update.message, text = message.text, chatId = message.from?.id {
                if text == "Hello" {
                    bot.sendMessageAsync(chat_id: chatId, text: "How are you?")
                }
            }
        }
        print("Server stopped due to error: \(bot.lastError)")
    }
    
}
