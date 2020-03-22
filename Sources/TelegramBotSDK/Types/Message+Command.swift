//
// Message+Command.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

extension Message {
	public func extractCommand(for bot: TelegramBot) -> String? {
		return text?.without(botName: bot.name) ?? nil
	}
	
	public func addressed(to bot: TelegramBot) -> Bool {
		guard let text = text else { return true }
		return text.without(botName: bot.name) != nil
	}
}
