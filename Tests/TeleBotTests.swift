//
// TeleBotTests.swift
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
@testable import TeleBot

class TeleBotTests: XCTestCase {
    var testDataPath: String!
    var token: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = NSBundle(forClass: self.dynamicType).resourcePath {
            testDataPath = path
        } else {
            XCTFail("Unable to get resourcePath")
        }
        
        let environment = NSProcessInfo.processInfo().environment
        token = environment["TelegramTestBotToken"]
        XCTAssert(token != nil, "Please create a bot for testing")
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

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
    
    func testRequestsSynchronous() {
        print("Token: \(token)")
        let bot = TelegramBot(token: token)
        let user = bot.getMe()
        print("getMe: user=\(user)")
    }
}
