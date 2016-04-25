//
// TelegramBot+Utils.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension TelegramBot {

    public func respondPrivatelySync(_ userText: String, groupText: String? = nil) {
        if !userText.isEmpty {
            sendMessageSync(chatId: lastMessage.from.id, text: userText)
        }
        if let groupText = groupText where !groupText.isEmpty {
            if case .GroupChatType = lastMessage.chat {
                sendMessageSync(chatId: lastMessage.chat.id, text: groupText)
            }
        }
    }
    
	public func respondSync(_ text: String, parameters: [String: Any?] = [:]) {
        if !text.isEmpty {
			sendMessageSync(chatId: lastMessage.chat.id, text: text, parameters: parameters)
        }
    }
	
    public func reportErrorSync(_ text: String, errorDescription: String) {
		respondSync(text)
        print("ERROR: \(errorDescription)")
    }
	
    public func reportErrorSync(errorDescription: String) {
        respondSync("❗ Ошибка при выполнении операции. Приносим свои извинения. Разработчики бота будут проинформированы об ошибке.")
        print("ERROR: \(errorDescription)")
    }
}
