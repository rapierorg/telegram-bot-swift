//
// TelegramBot+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

extension TelegramBot {
	public static var unhandledErrorText = "❗ Error while performing the operation."

    @discardableResult
    public func reportErrorSync(chatId: Int64, text: String, errorDescription: String) -> Message? {
		logger("ERROR: \(errorDescription)")
		return sendMessageSync(chat_id: chatId, text: text)
    }
	
    @discardableResult
	public func reportErrorSync(chatId: Int64, errorDescription: String) -> Message? {
		logger("ERROR: \(errorDescription)")
		return sendMessageSync(chat_id: chatId, text: TelegramBot.unhandledErrorText)
	}
	
	public func reportErrorAsync(chatId: Int64, text: String, errorDescription: String, completion: SendMessageCompletion? = nil) {
		logger("ERROR: \(errorDescription)")
		sendMessageAsync(chat_id: chatId, text: text, completion: completion)
	}
	
	public func reportErrorAsync(chatId: Int64, errorDescription: String, completion: SendMessageCompletion? = nil) {
		logger("ERROR: \(errorDescription)")
		sendMessageAsync(chat_id: chatId, text: TelegramBot.unhandledErrorText, completion: completion)
	}
}
