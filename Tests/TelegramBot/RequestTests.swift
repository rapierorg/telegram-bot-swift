// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import XCTest
@testable import TelegramBot

class RequestTests: XCTestCase {
	var token: String!
	var bot: TelegramBot!
	var chatId: Int64!
	
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
		
		token = readToken("TEST_BOT_TOKEN")
		chatId = readConfigurationValue("TEST_CHAT_ID")
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
	
	func testGetMe() {
		check( bot.getMeSync() )
	}
	
	func testSendMessage() {
		let response = bot.sendMessageSync(chat_id: chatId, text: "testSendMessage1: this is a simple message")
		check(response)
		
		let messageId = response!.message_id
		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage2: a reply to previous message", parameters: ["reply_to_message_id": messageId]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage3: url without preview: http://google.com", parameters: ["disable_web_page_preview": true]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage4: markdown: *bold* _italic_ [link](http://google.com)", parameters: ["parse_mode": "Markdown"]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage5: html: <b>bold</b> <i>italic</i>\n<code>void main() {\n  return 0;\n}</code>", parameters: ["parse_mode": "HTML"]) )
	}
	
	func testShowKeyboardWithText() {
		let markup = ReplyKeyboardMarkup()
		markup.keyboardStrings = [
			[ "Button 1", "Button 2" ],
			[ "Button 3", "Button 4" ]
		]
		check( bot.sendMessageSync(chat_id: chatId, text: "Here is a keyboard", parameters: ["reply_markup": markup]) )
	}
	
	func testShowKeyboardWithButtons() {
		let markup = ReplyKeyboardMarkup()
		
		let button1 = KeyboardButton()
		button1.text = "Button 1"
		
		let button2 = KeyboardButton()
		button2.text = "Button 2"

		let button3 = KeyboardButton()
		button3.text = "Request Contact"
		button3.request_contact = true
		
		let button4 = KeyboardButton()
		button4.text = "Request Location"
		button4.request_location = true
		
		markup.keyboardButtons = [
			[ button1, button2 ],
			[ button3, button4 ]
		]
		check( bot.sendMessageSync(chat_id: chatId, text: "Here is a keyboard", parameters: ["reply_markup": markup]) )
	}
	
	func check<T where T: JsonObject>(_ result: T?) {
		XCTAssert(result?.prettyPrint() != nil)
	}
}
