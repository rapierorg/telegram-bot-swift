// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import Dispatch

public extension TelegramBot {
    typealias SendStickerCompletion = (_ result: Message?, _ error: DataTaskError?) -> ()

    /// Use this method to send .webp stickers. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - sticker: Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .webp file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
    ///     - disable_notification: Sends the message silently. Users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
    @discardableResult
    public func sendStickerSync(
            chat_id: ChatId,
            sticker: FileInfo,
            disable_notification: Bool? = nil,
            reply_to_message_id: Int? = nil,
            reply_markup: ReplyMarkup? = nil,
            _ parameters: [String: Any?] = [:]) -> Message? {
        return requestSync("sendSticker", defaultParameters["sendSticker"], parameters, [
            "chat_id": chat_id,
            "sticker": sticker,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup])
    }

    /// Use this method to send .webp stickers. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - sticker: Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .webp file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
    ///     - disable_notification: Sends the message silently. Users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendsticker>
    public func sendStickerAsync(
            chat_id: ChatId,
            sticker: FileInfo,
            disable_notification: Bool? = nil,
            reply_to_message_id: Int? = nil,
            reply_markup: ReplyMarkup? = nil,
            _ parameters: [String: Any?] = [:],
            queue: DispatchQueue = .main,
            completion: SendStickerCompletion? = nil) {
        return requestAsync("sendSticker", defaultParameters["sendSticker"], parameters, [
            "chat_id": chat_id,
            "sticker": sticker,
            "disable_notification": disable_notification,
            "reply_to_message_id": reply_to_message_id,
            "reply_markup": reply_markup],
            queue: queue, completion: completion)
    }
}

