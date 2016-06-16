// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import XCTest
@testable import TelegramBot

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
		
		token = readToken("TEST_BOT_TOKEN")
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
		let response = bot.sendMessageSync(chat_id: chatId, text: "testSendMessage1: this is a simple message")
		check(response)
		
		let messageId = response!.message_id
		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage2: a reply to previous message", ["reply_to_message_id": messageId]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage3: url without preview: http://google.com", ["disable_web_page_preview": true]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage4: markdown: *bold* _italic_ [link](http://google.com)", ["parse_mode": "Markdown"]) )

		check( bot.sendMessageSync(chat_id: chatId, text: "testSendMessage5: html: <b>bold</b> <i>italic</i>\n<code>void main() {\n  return 0;\n}</code>", ["parse_mode": "HTML"]) )
	}
	
	func testShowKeyboardWithText() {
		var markup = ReplyKeyboardMarkup()
		markup.keyboardStrings = [
			[ "Button 1", "Button 2" ],
			[ "Button 3", "Button 4" ]
		]
		check( bot.sendMessageSync(chat_id: chatId, text: "Here is a keyboard", ["reply_markup": markup]) )
	}
	
	func testShowKeyboardWithButtons() {
		var markup = ReplyKeyboardMarkup()
		
		var button1 = KeyboardButton()
		button1.text = "Button 1"
		
		var button2 = KeyboardButton()
		button2.text = "Button 2"

		var button3 = KeyboardButton()
		button3.text = "Share Contact"
		button3.request_contact = true
		
		var button4 = KeyboardButton()
		button4.text = "Share Location"
		button4.request_location = true
		
		markup.keyboardButtons = [
			[ button1, button2 ],
			[ button3, button4 ]
		]
		check( bot.sendMessageSync(chat_id: chatId, text: "Here is a keyboard", ["reply_markup": markup]) )
	}
	
	func testHideKeyboard() {
		let markup = ReplyKeyboardHide()
		check( bot.sendMessageSync(chat_id: chatId, text: "Hiding the keyboard", ["reply_markup": markup]) )
	}
	
	func testForceReply() {
		let markup = ForceReply()
		check( bot.sendMessageSync(chat_id: chatId, text: "Force reply", ["reply_markup": markup]) )
	}
	
	//
	// forwardMessage
	//
	
	func testForwardMessage() {
		check( bot.forwardMessageSync(chat_id: chatId, from_chat_id: chatId, message_id: messageId) )
	}
	
	//
	// sendLocation
	//
	
	func testSendLocation() {
		check( bot.sendChatActionSync(chat_id: chatId, action: .find_location) )
		check( bot.sendLocationSync(chat_id: chatId, latitude: 50.4501, longitude: 30.5234) )
	}
	
	// Helper functions

	func check<T where T: JsonObject>(_ result: T?) {
		XCTAssert(result?.prettyPrint() != nil)
	}
}
