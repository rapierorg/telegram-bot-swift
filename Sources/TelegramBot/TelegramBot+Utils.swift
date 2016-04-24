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
	
//    public func reportError(groupText: String, errorDescription: String) {
//        respondToGroup(groupText)
//        print("ERROR: \(errorDescription)")
//    }
//    
//    public func reportError(_ errorDescription: String) {
//        respondToGroup("Unable to perform the operation. Please contact the developers.")
//        print("ERROR: \(errorDescription)")
//    }
}
