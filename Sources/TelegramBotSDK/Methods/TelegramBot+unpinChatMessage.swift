// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import Dispatch

public extension TelegramBot {
    typealias UnpinChatMessageCompletion = (_ result: Bool?, _ error: DataTaskError?) -> ()

    /// Use this method to unpin a message in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    /// - Returns: Bool on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#unpinchatmessage>
    @discardableResult
    public func unpinChatMessageSync(
            chatId: ChatId,
            _ parameters: [String: Any?] = [:]) -> Bool? {
        return requestSync("unpinChatMessage", defaultParameters["unpinChatMessage"], parameters, [
            "chat_id": chatId])
    }

    /// Use this method to unpin a message in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    /// - Returns: Bool on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#unpinchatmessage>
    public func unpinChatMessageAsync(
            chatId: ChatId,
            _ parameters: [String: Any?] = [:],
            queue: DispatchQueue = .main,
            completion: UnpinChatMessageCompletion? = nil) {
        return requestAsync("unpinChatMessage", defaultParameters["unpinChatMessage"], parameters, [
            "chat_id": chatId],
            queue: queue, completion: completion)
    }
}

