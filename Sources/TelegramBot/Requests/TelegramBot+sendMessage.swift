//
// TelegramBot+sendMessage.swift
//
// Copyright (c) 2016 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public extension TelegramBot {
	public static var sendMessageDefaultParameters: [String: Any?] = [:]
	
	typealias SendMessageCompletion = (message: /*NS*/Message?, error: /*NS*/DataTaskError?)->()
	
	/// Send text message. Blocking version.
	/// - Returns: Sent message on success. Nil on error, in which case `lastError` contains the details.
	/// - SeeAlso: https://core.telegram.org/bots/api#sendmessage
	public func sendMessageSync(chatId: Int, text: String,
	                        parameters: [String: Any?] = [:]) -> Message? {
		var result: /*NS*/Message!
		let sem = dispatch_semaphore_create(0)
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		sendMessageAsync(chatId: chatId, text: text, parameters:  parameters, queue: queue) {
			message, error in
			result = message
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		//dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
		return result
	}
	
    /// Send text messages. Asynchronous version.
	/// - Returns: Sent message on success. Nil on error, in which case `error` contains the details.
	/// - SeeAlso: https://core.telegram.org/bots/api#sendmessage
	public func sendMessageAsync(chatId: Int, text: String,
	                        parameters: [String: Any?] = [:],
	                        queue: dispatch_queue_t = dispatch_get_main_queue(),
	                        completion: SendMessageCompletion? = nil) {
        var allParameters: [String: Any?] = [
            "chat_id": chatId,
            "text": text
        ]
		allParameters += TelegramBot.sendMessageDefaultParameters
		allParameters += parameters
        startDataTaskForEndpoint("sendMessage", parameters: allParameters) {
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
                completion?(message: message, error: error)
            }
        }
    }
}
