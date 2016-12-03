//
// TelegramBot+sendMessage+Utils.swift
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
import SwiftyJSON

import Foundation

public extension TelegramBot {
    /// Use this method to send text messages. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - text: Text of the message to be sent
    ///     - parse_mode: Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    ///     - disable_web_page_preview: Disables link previews for links in this message
    ///     - disable_notification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to hide reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
    @discardableResult
    public func sendMessageSync(
        _ chat_id: ChatId,
        _ text: String,
        parse_mode: String? = nil,
        disable_web_page_preview: Bool? = nil,
        disable_notification: Bool? = nil,
        reply_to_message_id: Int? = nil,
        reply_markup: ReplyMarkup? = nil,
        _ parameters: [String: Any?] = [:]) -> Message? {
        return requestSync("sendMessage", defaultParameters["sendMessage"], parameters, [
            "chat_id": chat_id,
            "text": text,
            "parse_mode": parse_mode,
            "disable_web_page_preview": disable_web_page_preview,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup])
    }
    
    /// Use this method to send text messages. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - text: Text of the message to be sent
    ///     - parse_mode: Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    ///     - disable_web_page_preview: Disables link previews for links in this message
    ///     - disable_notification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to hide reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendmessage>
    public func sendMessageAsync(
        _ chat_id: ChatId,
        _ text: String,
        parse_mode: String? = nil,
        disable_web_page_preview: Bool? = nil,
        disable_notification: Bool? = nil,
        reply_to_message_id: Int? = nil,
        reply_markup: ReplyMarkup? = nil,
        _ parameters: [String: Any?] = [:],
        queue: DispatchQueue = .main,
        completion: SendMessageCompletion? = nil) {
        return requestAsync("sendMessage", defaultParameters["sendMessage"], parameters, [
            "chat_id": chat_id,
            "text": text,
            "parse_mode": parse_mode,
            "disable_web_page_preview": disable_web_page_preview,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup],
                            queue: queue, completion: completion)
    }
}
