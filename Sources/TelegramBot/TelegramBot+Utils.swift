// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	public static var unhandledErrorText = "❗Error while performing the operation."

    public func respondPrivatelySync(_ userText: String, groupText: String? = nil) {
        if !userText.isEmpty {
            sendMessageSync(chatId: lastMessage.from.id, text: userText)
        }
        if let groupText = groupText where !groupText.isEmpty {
            if lastMessage.chat.typeString == "group" {
                sendMessageSync(chatId: lastMessage.chat.id, text: groupText)
            }
        }
    }

	public func respondPrivatelyAsync(_ userText: String, groupText: String? = nil,
			onDidSendToUser userCompletion: SendMessageCompletion? = nil,
			onDidSendToGroup groupCompletion: SendMessageCompletion? = nil) {
		if !userText.isEmpty {
			sendMessageAsync(chatId: lastMessage.from.id, text: userText, completion: userCompletion)
		}
		if let groupText = groupText where !groupText.isEmpty {
			if lastMessage.chat.typeString == "group" {
				sendMessageAsync(chatId: lastMessage.chat.id, text: groupText, completion: groupCompletion)
			}
		}
	}
    
	public func respondSync(_ text: String, parameters: [String: Any?] = [:]) {
        if !text.isEmpty {
			sendMessageSync(chatId: lastMessage.chat.id, text: text, parameters: parameters)
        }
    }
	
	public func respondAsync(_ text: String, parameters: [String: Any?] = [:], completion: SendMessageCompletion? = nil) {
		if !text.isEmpty {
			sendMessageAsync(chatId: lastMessage.chat.id, text: text, parameters: parameters, completion: completion)
		}
	}
	
    public func reportErrorSync(_ text: String, errorDescription: String) {
		print("ERROR: \(errorDescription)")
		respondSync(text)
    }
	
	public func reportErrorAsync(_ text: String, errorDescription: String, completion: SendMessageCompletion? = nil) {
		print("ERROR: \(errorDescription)")
		respondAsync(text, completion: completion)
	}
	
    public func reportErrorSync(errorDescription: String) {
		print("ERROR: \(errorDescription)")
        respondSync(TelegramBot.unhandledErrorText)
    }
	
	public func reportErrorAsync(errorDescription: String, completion: SendMessageCompletion? = nil) {
		print("ERROR: \(errorDescription)")
		respondAsync(TelegramBot.unhandledErrorText, completion: completion)
	}
}
