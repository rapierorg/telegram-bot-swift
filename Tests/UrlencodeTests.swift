//
// UrlencodeTests.swift
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

class UrlencodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueryUrlencode() {
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
    
    func testFormUrlencodeSimple() {
        let parameters = [
            "key1": "value1",
            "key2": "value2",
            "key3": "value3"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key1=value1&key3=value3&key2=value2")
    }
    
    func testFormUrlencodePercentEscaping() {
        let parameters = [
            "key1": "value 1",
            "key2": "валюе\t2",
            "key3": "!@#$%^&*()-=+_"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key1=value+1&key3=%21%40%23%24%25%5E%26*%28%29-%3D%2B_&key2=%D0%B2%D0%B0%D0%BB%D1%8E%D0%B5%092")
        
    }
    
    func testFormUrlencodeMixed() {
        let value3: Int? = nil
        let parameters: [String: Any?] = [
            "key1": "value1",
            "key2": 123,
            "key3": value3
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key1=value1&key2=123")
    }
    
    func testFormUrlencodeNilValue() {
        let parameters: [String: Any?] = [
            "key": nil
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "")
    }
    
    func testFormUrlencodeOptionalString() {
        let value: String? = "value"
        let parameters: [String: Any?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeAny() {
        let parameters: [String: Any?] = [
            "key": "value"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeOptionalAsAny() {
        let value: String? = "value"
        let parameters: [String: Any?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeNilAsAny() {
        let value: String? = nil
        let parameters: [String: Any?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "")
    }
    
    func testFormUrlencodeTypes() {
        let parameters: [String: Any?] = [
            "key1": 123,
            "key2": 123.456,
            "key3": true,
            "key4": false,
            "key5": "text"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key1=123&key5=text&key2=123.456&key3=")
    }
    
    func testFormUrlencodeReplyMarkup() {
        let keyboardMarkup = ReplyKeyboardMarkup()
        keyboardMarkup.keyboard = [
            [ "A", "B", "C" ],
            [ "D", "E" ]
        ]
        let replyMarkup = ReplyMarkup.ReplyKeyboardMarkupType(keyboardMarkup)
        let parameters: [String: Any?] = [
            "key": replyMarkup
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        // key={"keyboard":[["A","B","C"],["D","E"]]}
        XCTAssert(encoded == "key=%7B%22keyboard%22%3A%5B%5B%22A%22%2C%22B%22%2C%22C%22%5D%2C%5B%22D%22%2C%22E%22%5D%5D%7D")
    }
}

