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
        let environment = NSProcessInfo.processInfo().environment
        token = environment["TelegramTestBotToken"]
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testServer() {
        let bot = TelegramBot(token: token)

        while let update = bot.nextUpdate() {
            print("--- updateId: \(update.updateId)")
            print("update: \(update.prettyPrint)")
            if let message = update.message, text = message.text {
                if text == "Hello" {
                    bot.sendMessageToChatId(message.from.id, text: "How are you?")
                }
            }
        }
        print("Server stopped due to error: \(bot.lastError)")
    }
    
}
