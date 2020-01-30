//
// RouterTests.swift
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

class RouterTests: XCTestCase {
    var token: String!
    var bot: TelegramBot!

    var update = Update(updateId: 1)

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let chat = Chat(id: 1, type: "")
        update.message = Message(messageId: 1, date: Date(), chat: chat)

        token = readToken(from: "TEST_BOT_TOKEN")
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
        XCTAssertTrue ( matches(path: "HEllo", text: "/helLO") )
        XCTAssertTrue ( matches(path: "HEllo111", text: "helLO") )

        XCTAssertFalse( matches(path: "HEllo", text: "helLO111") )

        // This one should show a warning:
        XCTAssertTrue ( matches(path: "/HEllo", text: "helLO") )
}
    
    func testMultiPath() {
        XCTAssertTrue ( matches(paths: ["path1", "path2"],
                                text: "path1") )
        XCTAssertTrue ( matches(paths: ["path1", "path2"],
                                text: "path2") )
        XCTAssertFalse( matches(paths: ["path1", "path2"],
                                text: "path3") )
    }
    
    func testMultiWordCommands() {
        XCTAssertTrue ( matches(path: "hello world", text: "hello world") )
        XCTAssertFalse( matches(path: "hello world", text: "hello") )
        XCTAssertFalse( matches(path: "hello world", text: "") )
        
        XCTAssertTrue ( matches(path: "hello world", text: "he wo") )
        XCTAssertFalse( matches(path: "hello world", text: "he word") )

        XCTAssertFalse( matches(path: "hello world", text: "he wo", options: .slashRequired) )
        XCTAssertTrue ( matches(path: "hello world", text: "/he wo", options: .slashRequired) )

        XCTAssertFalse( matches(path: "hello world", text: "/he wo", options: .exactMatch) )
        XCTAssertTrue ( matches(path: "/hello world", text: "/he wo", options: .exactMatch) )

        XCTAssertTrue ( matches(path: "/hello world", text: "/he     wo", options: .exactMatch) )
    }
    
    func testPartialMatch() {
        update.message?.text = "hello a b c"
        
        var matched = false
        
        let router = Router(bot: bot)
        router["hello"] = { context in
            return true
        }
        router.partialMatch = { context in
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        XCTAssertTrue(matched)
    }

    func testUnknownCommand() {
        update.message?.text = "/badcmd a b c"
        
        var matched = false
        
        let router = Router(bot: bot)
        router["hello"] = { context in
            return true
        }
        router.unmatched = { context in
            print("Unknown command: \(context.args.scanRestOfString())")
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        XCTAssertTrue(matched)
    }
    
    func testRouterChaining() {
        update.message?.text = "/hello"
        
        var matched = false
        
        let router1 = Router(bot: bot)
        let router2 = Router(bot: bot)

        router2["hello"] = { context in
            matched = true
            return true
        }

        router1.unmatched = { context in
            do { try router2.process(update: self.update) }
            catch { XCTFail() }
            return true
        }
        
        do { try router1.process(update: update) }
        catch { XCTFail() }
        
        XCTAssertTrue(matched)
    }
    
    func testRouterChaining2() {
        update.message?.text = "/hello"
        
        var matched = false
        
        let router1 = Router(bot: bot)
        let router2 = Router(bot: bot)
        
        router2["hello"] = { context in
            matched = true
            return true
        }
        
        router1.unmatched = router2.handler
        
        do { try router1.process(update: update) }
        catch { XCTFail() }
        
        XCTAssertTrue(matched)
    }

    func matches(path: String, text: String, options: Command.Options = []) -> Bool {
        update.message?.text = text

        var matched = false
        
        let router = Router(bot: bot)
        router[path, options] = { context in
            print("path=\(path) text=\(text) command=\(context.command)")
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
            print("paths=\(paths) text=\(text) command=\(context.command)")
            matched = true
            return true
        }
        
        do { try router.process(update: update) }
        catch { XCTFail() }
        
        return matched
    }

    static var allTests : [(String, (RouterTests) -> () throws -> Void)] {
        return [
            ("testRouter", testRouter),
            ("testCaseSensitivity", testCaseSensitivity),
            ("testMultiPath", testMultiPath),
            ("testMultiWordCommands", testMultiWordCommands),
            ("testPartialMatch", testPartialMatch),
            ("testUnknownCommand", testUnknownCommand),
            ("testRouterChaining", testRouterChaining),
            ("testRouterChaining2", testRouterChaining2),
        ]
    }
}
