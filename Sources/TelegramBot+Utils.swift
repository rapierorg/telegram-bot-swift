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
        if !text.isEmpty {
            sendMessage(chatId: lastMessage.from.id, text: text)
        }
        if let groupText = groupText where !groupText.isEmpty {
            if case .GroupChatType = lastMessage.chat {
                sendMessage(chatId: lastMessage.chat.id, text: groupText)
            }
        }
    }
    
    func respondToGroup(groupText: String) {
        if !groupText.isEmpty {
            sendMessage(chatId: lastMessage.chat.id, text: groupText)
        }
    }
    
    func reportError(groupText: String, errorDescription: String) {
        respondToGroup(groupText)
        print("ERROR: \(errorDescription)")
    }
    
    func reportError(errorDescription: String) {
        respondToGroup("Unable to perform the operation. Please contact the developers.")
        print("ERROR: \(errorDescription)")
    }
}
