//
// BlockingServerTests.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2018 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

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
            print("--- update: \(update)")
            if let message = update.message, let text = message.text, let chatId = message.from?.id {
                if text == "Hello" {
                    bot.sendMessageAsync(chatId: .chat(chatId), text: "How are you?")
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

