//
// UrlencodeTests.swift
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
        XCTAssert(encoded.contains("key1=value1") && encoded.contains("key2=value2") && encoded.contains("key3=value3"))
    }
    
    func testFormUrlencodePercentEscaping() {
        let parameters = [
            "key1": "value 1",
            "key2": "валюе\t2",
            "key3": "!@#$%^&*()-=+_"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded.contains("key1=value+1") && encoded.contains("key2=%D0%B2%D0%B0%D0%BB%D1%8E%D0%B5%092") && encoded.contains("key3=%21%40%23%24%25%5E%26*%28%29-%3D%2B_"))
        
    }
    
    func testFormUrlencodeMixed() {
        let value3: Int? = nil
        let parameters: [String: Encodable?] = [
            "key1": "value1",
            "key2": 123,
            "key3": value3
        ]
        guard let encoded = HTTPUtils.formUrlencode(parameters) else {
            XCTFail()
            return
        }
        XCTAssert(encoded.contains("key1=value1") && encoded.contains("key2=123") && !encoded.contains("key3"))
    }
    
    func testFormUrlencodeNilValue() {
        let parameters: [String: Encodable?] = [
            "key": nil
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "")
    }
    
    func testFormUrlencodeOptionalString() {
        let value: String? = "value"
        let parameters: [String: Encodable?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeAny() {
        let parameters: [String: Encodable?] = [
            "key": "value"
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeOptionalAsAny() {
        let value: String? = "value"
        let parameters: [String: Encodable?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "key=value")
    }
    
    func testFormUrlencodeNilAsAny() {
        let value: String? = nil
        let parameters: [String: Encodable?] = [
            "key": value
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        XCTAssert(encoded == "")
    }
    
    func testFormUrlencodeTypes() {
        let parameters: [String: Encodable?] = [
            "key1": 123,
            "key2": 123.456,
            "key3": true,
            "key4": false,
            "key5": "text"
        ]
        guard let encoded = HTTPUtils.formUrlencode(parameters) else {
            XCTFail()
            return
        }
        XCTAssert(encoded.contains("key1=123") && encoded.contains("key2=123.456") && encoded.contains("key3=true") && !encoded.contains("key4") && encoded.contains("key5=text"))
    }
    
    func testFormUrlencodeReplyMarkup() {
        let keyboardMarkup = ReplyKeyboardMarkup(keyboard: [
            [ KeyboardButton(text: "A"), KeyboardButton(text: "B"), KeyboardButton(text: "C") ],
            [ KeyboardButton(text: "D"), KeyboardButton(text: "E") ]
        ])
        let parameters: [String: Encodable?] = [
            "key": keyboardMarkup
        ]
        let encoded = HTTPUtils.formUrlencode(parameters)
        print(encoded)
        // key={"keyboard":[["A","B","C"],["D","E"]]}
        XCTAssert(encoded == "key=%7B%22keyboard%22%3A%5B%5B%7B%22text%22%3A%22A%22%7D%2C%7B%22text%22%3A%22B%22%7D%2C%7B%22text%22%3A%22C%22%7D%5D%2C%5B%7B%22text%22%3A%22D%22%7D%2C%7B%22text%22%3A%22E%22%7D%5D%5D%7D")
    }

    static var allTests : [(String, (UrlencodeTests) -> () throws -> Void)] {
        return [
            ("testQueryUrlencode", testQueryUrlencode),
            ("testFormUrlencodeSimple", testFormUrlencodeSimple),
            ("testFormUrlencodePercentEscaping", testFormUrlencodePercentEscaping),
            ("testFormUrlencodeMixed", testFormUrlencodeMixed),
            ("testFormUrlencodeNilValue", testFormUrlencodeNilValue),
            ("testFormUrlencodeOptionalString", testFormUrlencodeOptionalString),
            ("testFormUrlencodeAny", testFormUrlencodeAny),
            ("testFormUrlencodeOptionalAsAny", testFormUrlencodeOptionalAsAny),
            ("testFormUrlencodeNilAsAny", testFormUrlencodeNilAsAny),
            ("testFormUrlencodeTypes", testFormUrlencodeTypes),
            ("testFormUrlencodeReplyMarkup", testFormUrlencodeReplyMarkup),
        ]
    }
}

