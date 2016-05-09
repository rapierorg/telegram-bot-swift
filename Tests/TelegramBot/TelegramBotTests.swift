//
// TelegramBotTests.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import XCTest
@testable import TelegramBot

class TelegramBotTests: XCTestCase {
    var token: String!
    let connectionTimeout = 10.0
    let invalidUrl = "https://localhost:7777/doesNotExist"
    
    override func setUp() {
        super.setUp()
		
        let environment = NSProcessInfo.processInfo().environment
        token = environment["TEST_BOT_TOKEN"]
        if token == nil {
            do {
                token = try String(contentsOfFile: "test_bot_token.txt", encoding: NSUTF8StringEncoding)
                token.trim()
            } catch {
            }
        }

        if token == nil {
            fatalError("Please create a bot for testing and add it's token to environment variable TEST_BOT_TOKEN in Scheme settings")
            // -------------------
            // How to create a bot
            // -------------------
            // * In Telegram, add BotFather.
            // /newbot
            // TestBot
            // apitest_bot
            // BotFather will return a token.
            // * In Xcode, click on project scheme, Edit Scheme -> Run. Add to Environment Variables:
            // TEST_BOT_TOKEN yourToken
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testGetMeSynchronous() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        let user = bot.getMeSync()
        let error = bot.lastError
        print("getMeSync: user: \(user), error: \(error)")
    }
    
    func testGetMeAsynchronous() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        
        let expectGetMe = expectation(withDescription: "getMe")
        bot.getMeAsync { user, error in
            print("getMeAsync: user: \(user), error: \(error)")
            expectGetMe.fulfill()
        }
        waitForExpectations(withTimeout: connectionTimeout) { error in
            print("getMeAsync: \(error)")
        }
    }

    func testGetUpdatesSynchronous() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        let updates = bot.getUpdatesSync()
        let error = bot.lastError
        print("getUpdatesSync: \(updates), error: \(error)")
    }
    
    func testGetUpdatesAsynchronous() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        
        let expectGetUpdates = expectation(withDescription: "getUpdates")
        bot.getUpdatesAsync { updates, error in
            print("getUpdatesAsync: updates: \(updates), error: \(error)")
            expectGetUpdates.fulfill()
        }
        waitForExpectations(withTimeout: connectionTimeout) { error in
            print("getUpdatesAsync: \(error)")
        }
    }

    func testBadToken() {
        let badBot = TelegramBot(token: "badToken", fetchBotInfo: false)
        let user = badBot.getMeSync()
        let error = badBot.lastError
        print("getMeSync: user: \(user), error: \(error)")
    }
    
    func testErrorHandlingAsynchronous() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        bot.url = invalidUrl

        let expectGetMe = expectation(withDescription: "getMe")

        // Comment out custom errorHandler to see
        // autoreconnects in action (but the test
        // will fail)
#if true
        bot.errorHandler = { task, error in
            print("getMe: errorHandler: task: \(task), error: \(error)")
            expectGetMe.fulfill()
        }
#endif

        bot.getMeAsync { user in
            XCTFail("Expected error handler to run")
        }
        
        waitForExpectations(withTimeout: connectionTimeout) { error in
            print("getMeAsync: \(error)")
        }
        
    }
}
