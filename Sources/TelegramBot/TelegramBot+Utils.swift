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

    public func respondPrivately(_ text: String, groupText: String? = nil) {
        if !text.isEmpty {
            sendMessage(chatId: lastMessage.from.id, text: text)
        }
        if let groupText = groupText where !groupText.isEmpty {
            if case .GroupChatType = lastMessage.chat {
                sendMessage(chatId: lastMessage.chat.id, text: groupText)
            }
        }
    }
    
    public func respondToGroup(_ groupText: String) {
        if !groupText.isEmpty {
            sendMessage(chatId: lastMessage.chat.id, text: groupText)
        }
    }
    
    public func reportError(groupText: String, errorDescription: String) {
        respondToGroup(groupText)
        print("ERROR: \(errorDescription)")
    }
    
    public func reportError(_ errorDescription: String) {
        respondToGroup("Unable to perform the operation. Please contact the developers.")
        print("ERROR: \(errorDescription)")
    }
}
