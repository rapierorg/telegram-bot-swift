// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension Message {
	public func extractCommand(of bot: TelegramBot) -> String? {
		return text?.without(botName: bot.name) ?? nil
	}
	
	public func addressed(to bot: TelegramBot) -> Bool {
		guard let text = text else { return true }
		return text.without(botName: bot.name) != nil
	}
}
