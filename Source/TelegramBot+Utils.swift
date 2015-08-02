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

    func respondPrivately(text: String, groupText: String? = nil) {
        sendMessage(chatId: lastMessage.from.id, text: text)
        if let groupText = groupText {
            if case .GroupChatType = lastMessage.chat {
                sendMessage(chatId: lastMessage.chat.id, text: groupText)
            }
        }
    }
    
    func respondToGroup(groupText: String) {
        sendMessage(chatId: lastMessage.chat.id, text: groupText)
    }
}
