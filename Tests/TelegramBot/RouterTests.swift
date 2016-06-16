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
        XCTAssertTrue ( matches(path: "hello", text: "hello") )
        XCTAssertTrue ( matches(path: "hello", text: "he") )
        XCTAssertTrue ( matches(path: "hello", text: "/hello") )
        XCTAssertTrue ( matches(path: "hello", text: "/he") )
        XCTAssertFalse( matches(path: "hello", text: "helllo") )

        XCTAssertTrue ( matches(paths: ["hello", "world"], text: "hello") )
        XCTAssertTrue ( matches(paths: ["hello", "world"], text: "world") )
    }
    
    func testCaseSensitivity() {
        XCTAssertTrue ( matches(path: "HEllo", text: "helLO") )
        XCTAssertTrue ( matches(path: "/HEllo", text: "helLO") )
        XCTAssertTrue ( matches(path: "HEllo111", text: "helLO") )

        XCTAssertFalse( matches(path: "HEllo", text: "helLO111") )
}
    
    func testMultiPath() {
        update.message?.text = "path2"
        
        var matched = false
        
        let router = Router(bot: bot)
        router["path1", "path2"] = { context in
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }

        XCTAssertTrue(matched)
    }
    
    func matches(path: String, text: String) -> Bool {
        update.message?.text = text

        var matched = false
        
        let router = Router(bot: bot)
        router[path] = { context in
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        return matched
    }
    
    func matches(paths: [String], text: String) -> Bool {
        update.message?.text = text
        
        var matched = false
        
        let router = Router(bot: bot)
        router[paths] = { context in
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        return matched
    }
}
