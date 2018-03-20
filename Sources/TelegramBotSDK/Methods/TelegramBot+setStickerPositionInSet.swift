// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import Dispatch

public extension TelegramBot {
    typealias SetStickerPositionInSetCompletion = (_ result: Bool?, _ error: DataTaskError?) -> ()

    /// Use this method to move a sticker in a set created by the bot to a specific position . Returns True on success.
    /// - Parameters:
    ///     - sticker: File identifier of the sticker
    ///     - position: New sticker position in the set, zero-based
    /// - Returns: Bool on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#setstickerpositioninset>
    @discardableResult
    public func setStickerPositionInSetSync(
            sticker: String,
            position: Int,
            _ parameters: [String: Any?] = [:]) -> Bool? {
        return requestSync("setStickerPositionInSet", defaultParameters["setStickerPositionInSet"], parameters, [
            "sticker": sticker,
            "position": position])
    }

    /// Use this method to move a sticker in a set created by the bot to a specific position . Returns True on success.
    /// - Parameters:
    ///     - sticker: File identifier of the sticker
    ///     - position: New sticker position in the set, zero-based
    /// - Returns: Bool on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#setstickerpositioninset>
    public func setStickerPositionInSetAsync(
            sticker: String,
            position: Int,
            _ parameters: [String: Any?] = [:],
            queue: DispatchQueue = .main,
            completion: SetStickerPositionInSetCompletion? = nil) {
        return requestAsync("setStickerPositionInSet", defaultParameters["setStickerPositionInSet"], parameters, [
            "sticker": sticker,
            "position": position],
            queue: queue, completion: completion)
    }
}

