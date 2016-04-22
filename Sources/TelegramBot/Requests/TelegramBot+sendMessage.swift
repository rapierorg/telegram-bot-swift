//
// TelegramBot+sendMessage.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension TelegramBot {
    
    /// Send text messages. On success, the sent Message is returned.
    ///
    /// This is an asynchronous version of the method,
    /// a blocking one is also available.
    ///
    /// - Parameter chatId: Unique identifier for the message recipient — User or GroupChat id.
    /// - Parameter text: Text of the message to be sent.
    /// - Parameter disableWebPagePreview: Disables link previews for links in this message.
    /// - Parameter replyToMessageId: If the message is a reply, ID of the original message.
    /// - Parameter replyMarkup: Additional interface options.
    /// - Returns: Sent message on success. Null on error, in which case `error`
    ///            contains the details.
    /// - SeeAlso: `func sendMessageWithChatId(text:disableWebPagePreview:replyToMessageId:replyMarkup:)->Message?`
    public func sendMessage(chatId: Int, text: String, disableWebPagePreview: Bool? = nil, replyToMessageId: Int? = nil, replyMarkup: /*NS*/ReplyMarkup? = nil, completion: (message: /*NS*/Message?, error: /*NS*/DataTaskError?)->()) {
        sendMessage(chatId: chatId, text: text, disableWebPagePreview: disableWebPagePreview, replyToMessageId: replyToMessageId, replyMarkup: replyMarkup, queue: queue, completion: completion)
    }

    /// Send text messages. On success, the sent Message is returned.
    ///
    /// This is a blocking version of the method,
    /// an asynchronous one is also available.
    ///
    /// - Parameter chatId: Unique identifier for the message recipient — User or GroupChat id.
    /// - Parameter text: Text of the message to be sent.
    /// - Parameter disableWebPagePreview: Disables link previews for links in this message.
    /// - Parameter replyToMessageId: If the message is a reply, ID of the original message.
    /// - Parameter replyMarkup: Additional interface options.
    /// - Returns: Sent message on success. Null on error, in which case `error`
    ///            contains the details.
    /// - SeeAlso: `func sendMessageWithChatId(text:disableWebPagePreview:replyToMessageId:replyMarkup:completion:)->()`
    public func sendMessage(chatId: Int, text: String, disableWebPagePreview: Bool? = nil, replyToMessageId: Int? = nil, replyMarkup: /*NS*/ReplyMarkup? = nil) -> /*NS*/Message? {
        var result: /*NS*/Message!
        let sem = dispatch_semaphore_create(0)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        sendMessage(chatId: chatId, text: text, disableWebPagePreview: disableWebPagePreview, replyToMessageId: replyToMessageId, replyMarkup: replyMarkup, queue: queue) {
                message, error in
            result = message
            self.lastError = error
            dispatch_semaphore_signal(sem)
        }
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }
    
    private func sendMessage(chatId: Int, text: String, disableWebPagePreview: Bool?, replyToMessageId: Int?, replyMarkup: /*NS*/ReplyMarkup?, queue: dispatch_queue_t, completion: (message: /*NS*/Message?, error: /*NS*/DataTaskError?)->()) {
        let parameters: [String: Any?] = [
            "chat_id": chatId,
            "text": text,
            "disable_web_page_preview": disableWebPagePreview,
            "reply_to_message_id": replyToMessageId,
            "reply_markup": replyMarkup
        ]
        startDataTaskForEndpoint("sendMessage", parameters: parameters) {
            result, error in
			var error = error
            var message: /*NS*/Message?
            if error == nil {
                message = /*NS*/Message(json: result)
                if message == nil {
                    error = .ResultParseError(json: result)
                }
            }
            dispatch_async(queue) {
                completion(message: message, error: error)
            }
        }
    }
}
