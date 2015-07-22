//
// TelegramBotTests.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

    func testUrlencode() {
        let v1 = "value 1"
        let uv1 = v1.urlQueryEncode()
        XCTAssert(uv1 == "value%201")
        
        let v2 = "валюе\t2"
        let uv2 = v2.urlQueryEncode()
        XCTAssert(uv2 == "%D0%B2%D0%B0%D0%BB%D1%8E%D0%B5%092")
        
        let v3 = "!@#$%^&*()-=+_"
        let uv3 = v3.urlQueryEncode()
        XCTAssert(uv3 == "%21%40%23%24%25%5E%26%2A%28%29-%3D%2B_")
    }
    
    func testFormUrlencode() {
        let d1 = [
            "param1": "value1",
            "param2": "value2",
            "param3": "value3"
        ]
        let fd1 = d1.formUrlencode()
        XCTAssert(fd1 == "param3=value3&param1=value1&param2=value2")
        
        let d2 = [
            "param1": "value 1",
            "param2": "валюе\t2",
            "param3": "!@#$%^&*()-=+_"
        ]
        let fd2 = d2.formUrlencode()
        XCTAssert(fd2 == "param3=%21%40%23%24%25%5E%26*%28%29-%3D%2B_&param1=value+1&param2=%D0%B2%D0%B0%D0%BB%D1%8E%D0%B5%092")
    }
    
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
