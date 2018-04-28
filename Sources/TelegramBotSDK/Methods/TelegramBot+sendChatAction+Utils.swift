//
// TelegramBot+sendChatAction+Utils.swift
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
import Dispatch


public extension TelegramBot {
	public enum ChatAction: String {
		case typing = "typing"
		case upload_photo = "upload_photo"
		case record_video = "record_video"
		case upload_video = "upload_video"
		case record_audio = "record_audio"
		case upload_audio = "upload_audio"
		case upload_document = "upload_document"
		case find_location = "find_location"
	}
	
    /// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status).
    /// Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
    /// We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
    /// - Returns: Bool on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	@discardableResult
	public func sendChatActionSync(chat_id: ChatId, action: ChatAction,
	                               _ parameters: [String: Any?] = [:]) -> Bool? {
		return requestSync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		                   ["chat_id": chat_id, "action": action])
	}
	
    /// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status).
    /// Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
    /// We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
    /// - Returns: Bool on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	public func sendChatActionAsync(chat_id: ChatId, action: ChatAction,
	                                _ parameters: [String: Any?] = [:],
	                                queue: DispatchQueue = DispatchQueue.main,
	                                completion: SendChatActionCompletion? = nil) {
		requestAsync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		             ["chat_id": chat_id, "action": action],
		             queue: queue, completion: completion)
	}
}

