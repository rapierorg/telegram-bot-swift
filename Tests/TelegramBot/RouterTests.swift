// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import XCTest
@testable import TelegramBot

class RouterTests: XCTestCase {
    var token: String!
    var bot: TelegramBot!

    var update = Update()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        update.message = Message()

        token = readToken("TEST_BOT_TOKEN")
        bot = TelegramBot(token: token, fetchBotInfo: false)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRouter() {
        update.message?.text = "hello"
        print(update.message?.text)
        
        var passed = false

        let router = Router(bot: bot)
        router["hello"] = { context in
            passed = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        XCTAssert(passed)
    }
}
