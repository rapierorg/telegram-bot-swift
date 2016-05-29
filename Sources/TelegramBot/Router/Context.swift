// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Context {
	typealias T = Context
	
	public let bot: TelegramBot
	public let message: Message
	public let args: Arguments

	init(bot: TelegramBot, message: Message, scanner: NSScanner, command: String) {
		self.bot = bot
		self.message = message
		self.args = Arguments(scanner: scanner, command: command)
	}
}
