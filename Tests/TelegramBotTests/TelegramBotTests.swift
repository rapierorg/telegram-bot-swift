// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import XCTest
@testable import TelegramBot

class TelegramBotTests: XCTestCase {
    var token: String!
    let connectionTimeout = 10.0
    let invalidUrl = "https://localhost:7777/doesNotExist"
    
    override func setUp() {
        super.setUp()
		
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
		
		token = readToken(from: "TEST_BOT_TOKEN")
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
    
    func testGetMeSync() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        let user = bot.getMeSync()
        let error = bot.lastError
        print("getMeSync: user: \(user), error: \(error)")
    }
    
    func testGetMeAsync() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        
        let expectGetMe = expectation(description: "getMe")
        bot.getMeAsync { user, error in
            print("getMeAsync: user: \(user), error: \(error)")
            expectGetMe.fulfill()
        }
        waitForExpectations(timeout: connectionTimeout) { error in
            print("getMeAsync: \(error)")
        }
    }

    func testGetUpdatesSync() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        let updates = bot.getUpdatesSync()
        let error = bot.lastError
        print("getUpdatesSync: \(updates), error: \(error)")
    }
    
    func testGetUpdatesAsync() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        
        let expectGetUpdates = expectation(description: "getUpdates")
        bot.getUpdatesAsync { updates, error in
            print("getUpdatesAsync: updates: \(updates), error: \(error)")
            expectGetUpdates.fulfill()
        }
        waitForExpectations(timeout: connectionTimeout) { error in
            print("getUpdatesAsync: \(error)")
        }
    }

    func testBadToken() {
        let badBot = TelegramBot(token: "badToken", fetchBotInfo: false)
        let user = badBot.getMeSync()
        let error = badBot.lastError
        print("getMeSync: user: \(user), error: \(error)")
    }
    
    func testErrorHandlingAsync() {
        let bot = TelegramBot(token: token, fetchBotInfo: false)
        bot.url = invalidUrl

        let expectGetMe = expectation(description: "getMe")

        // Comment out custom errorHandler to see
        // autoreconnects in action (but the test
        // will fail)
#if true
        bot.errorHandler = { task, associatedData, error in
            print("getMe: errorHandler: task: \(task), error: \(error)")
            expectGetMe.fulfill()
        }
#endif

        bot.getMeAsync { user in
            XCTFail("Expected error handler to run")
        }
        
        waitForExpectations(timeout: connectionTimeout) { error in
            print("getMeAsync: \(error)")
        }
        
    }
}
