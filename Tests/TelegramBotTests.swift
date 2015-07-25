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
    var testDataPath: String!
    var token: String!
    let connectionTimeout = 10.0
    let invalidUrl = "https://localhost:7777/doesNotExist"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = NSBundle(forClass: self.dynamicType).resourcePath {
            testDataPath = path
        } else {
            fatalError("Unable to get resourcePath")
        }
        
        let environment = NSProcessInfo.processInfo().environment
        token = environment["TelegramTestBotToken"]
        if token == nil {
            fatalError("Please create a bot for testing and add it's token to environment variable TelegramTestBotToken in Scheme settings")
            // -------------------
            // How to create a bot
            // -------------------
            // * In Telegram, add BotFather.
            // /newbot
            // TestBot
            // apitest_bot
            // BotFather will return a token.
            // * In Xcode, click on project scheme, Edit Scheme -> Run. Add to Environment Variables:
            // TelegramTestBotToken yourToken
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
        let bot = TelegramBot(token: token)
        let user = bot.getMe()
        let error = bot.lastError
        print("getMe: user: \(user), error: \(error)")
    }
    
    func testGetMeAsynchronous() {
        let bot = TelegramBot(token: token)
        
        let expectGetMe = expectationWithDescription("getMe")
        bot.getMe { user, error in
            print("getMe: user: \(user), error: \(error)")
            expectGetMe.fulfill()
        }
        waitForExpectationsWithTimeout(connectionTimeout) { error in
            print("getMe: \(error)")
        }
    }

    func testGetUpdatesSynchronous() {
        let bot = TelegramBot(token: token)
        let updates = bot.getUpdatesWithOffset()
        let error = bot.lastError
        print("getUpdates: \(updates), error: \(error)")
    }
    
    func testGetUpdatesAsynchronous() {
        let bot = TelegramBot(token: token)
        
        let expectGetUpdates = expectationWithDescription("getUpdates")
        bot.getUpdatesWithOffset { updates, error in
            print("getUpdates: updates: \(updates), error: \(error)")
            expectGetUpdates.fulfill()
        }
        waitForExpectationsWithTimeout(connectionTimeout) { error in
            print("getUpdates: \(error)")
        }
    }

    func testBadToken() {
        let badBot = TelegramBot(token: "badToken")
        let user = badBot.getMe()
        let error = badBot.lastError
        print("getMe: user: \(user), error: \(error)")
    }
    
    func testErrorHandlingAsynchronous() {
        let bot = TelegramBot(token: token)
        bot.url = invalidUrl

        let expectGetMe = expectationWithDescription("getMe")

        // Comment out custom errorHandler to see
        // autoreconnects in action (but the test
        // will fail)
#if true
        bot.errorHandler = { task, error in
            print("getMe: errorHandler: task: \(task), error: \(error)")
            expectGetMe.fulfill()
        }
#endif

        bot.getMe { user in
            XCTFail("Expected error handler to run")
        }
        
        waitForExpectationsWithTimeout(connectionTimeout) { error in
            print("getMe: \(error)")
        }
        
    }
}
