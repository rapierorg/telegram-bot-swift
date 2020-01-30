//
// RequestTests.swift
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
import Foundation
@testable import TelegramBotSDK

class RequestTests: XCTestCase {
	var token: String!
	var bot: TelegramBot!
	var chatId: Int64!
	var messageId: Int!
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		
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
		chatId = readConfigurationValue("TEST_CHAT_ID")
		messageId = readConfigurationValue("TEST_MESSAGE_ID")
		bot = TelegramBot(token: token, fetchBotInfo: false)
		
		if chatId == nil {
			XCTFail("Please set TEST_CHAT_ID")
		}
		
		bot.defaultParameters["sendMessage"] = ["disable_notification": true]
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	//
	// getMe
	//
	
	func testGetMe() {
		check( bot.getMeSync() )
	}
	
	//
	// sendMessage
	//
	
	func testSendMessage() {
        let response = bot.sendMessageSync(chatId: .chat(chatId), text: "testSendMessage1: this is a simple message")
		check(response)
		
		let messageId = response!.messageId
		check( bot.sendMessageSync(chatId: .chat(chatId), text: "testSendMessage2: a reply to previous message", ["reply_to_message_id": messageId]) )

        check( bot.sendMessageSync(chatId: .chat(chatId), text: "testSendMessage3: url without preview: http://google.com", ["disable_web_page_preview": true]) )

        check( bot.sendMessageSync(chatId: .chat(chatId), text: "testSendMessage4: markdown: *bold* _italic_ [link](http://google.com)", ["parse_mode": "Markdown"]) )

        check( bot.sendMessageSync(chatId: .chat(chatId), text: "testSendMessage5: html: <b>bold</b> <i>italic</i>\n<code>void main() {\n  return 0;\n}</code>", parseMode: .html) )
	}
	
	func testShowKeyboardWithText() {
		let markup = ReplyKeyboardMarkup(keyboard: [
            [KeyboardButton(text: "Button 1"), KeyboardButton(text: "Button 2")],
            [KeyboardButton(text: "Button 3")]
        ])
        check( bot.sendMessageSync(chatId: .chat(chatId), text: "Here is a keyboard", ["reply_markup": markup]) )
	}
	
	func testShowKeyboardWithButtons() {
		let markup = ReplyKeyboardMarkup(keyboard: [])
		
        let button1 = KeyboardButton(text: "Button 1")
        let button2 = KeyboardButton(text: "Button 2")
        let button3 = KeyboardButton(text: "Share Contact", requestContact: true)
        let button4 = KeyboardButton(text: "Share Location", requestLocation: true)
		
		markup.keyboard = [
			[ button1, button2 ],
			[ button3, button4 ]
		]
		check( bot.sendMessageSync(chatId: .chat(chatId), text: "Here is a keyboard", ["reply_markup": markup]) )
	}
	
	func testHideKeyboard() {
		let markup = ReplyKeyboardRemove(removeKeyboard: true)
        check( bot.sendMessageSync(chatId: .chat(chatId), text: "Removing the keyboard", ["reply_markup": markup]) )
	}
	
	func testForceReply() {
		let markup = ForceReply(forceReply: true)
		check( bot.sendMessageSync(chatId: .chat(chatId), text: "Force reply", ["reply_markup": markup]) )
	}
	
	//
	// forwardMessage
	//
	
	func testForwardMessage() {
        check( bot.forwardMessageSync(chatId: .chat(chatId), fromChatId: .chat(chatId), messageId: messageId) )
	}
	
	//
	// sendLocation
	//
	
	func testSendLocation() {
        check( bot.sendChatActionSync(chatId: .chat(chatId), action: .findLocation) )
        check( bot.sendLocationSync(chatId: .chat(chatId), latitude: 50.4501, longitude: 30.5234) )
	}
	
    //
    // sendPhoto
    //
    
    func testSendPhoto() {
        let filename = "/tmp/test.jpg"
        let url = URL(fileURLWithPath: filename)
        let imageData: Data
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            XCTFail("\(error)")
            return
        }
        let inputFile = InputFile(filename: "test.jpg", data: imageData)
        bot.sendPhotoSync(chatId: .chat(chatId), photo: .inputFile(inputFile))
    }
    
	// Helper functions

	func check<T>(_ result: T?) where T: Codable {
		XCTAssert(result != nil)
	}

    static var allTests : [(String, (RequestTests) -> () throws -> Void)] {
        return [
            ("testGetMe", testGetMe),
	        ("testSendMessage", testSendMessage),
	        ("testShowKeyboardWithText", testShowKeyboardWithText),
	        ("testShowKeyboardWithButtons", testShowKeyboardWithButtons),
	        ("testHideKeyboard", testHideKeyboard),
	        ("testForceReply", testForceReply),
	        ("testForwardMessage", testForwardMessage),
	        ("testSendLocation", testSendLocation),
            ("testSendPhoto", testSendPhoto),
            //("testExample", testExample),
        ]
    }
}
