// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import Dispatch

public extension TelegramBot {
    typealias AnswerPreCheckoutQueryCompletion = (_ result: Bool?, _ error: DataTaskError?) -> ()

    /// Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.
    /// - Parameters:
    ///     - pre_checkout_query_id: Unique identifier for the query to be answered
    ///     - ok: Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.
    ///     - error_message: Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. "Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!"). Telegram will display this message to the user.
    /// - Returns: Bool on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#answerprecheckoutquery>
    @discardableResult
    public func answerPreCheckoutQuerySync(
            preCheckoutQueryId: String,
            ok: Bool,
            errorMessage: String? = nil,
            _ parameters: [String: Any?] = [:]) -> Bool? {
        return requestSync("answerPreCheckoutQuery", defaultParameters["answerPreCheckoutQuery"], parameters, [
            "pre_checkout_query_id": preCheckoutQueryId,
            "ok": ok,
            "error_message": errorMessage])
    }

    /// Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.
    /// - Parameters:
    ///     - pre_checkout_query_id: Unique identifier for the query to be answered
    ///     - ok: Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.
    ///     - error_message: Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. "Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!"). Telegram will display this message to the user.
    /// - Returns: Bool on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#answerprecheckoutquery>
    public func answerPreCheckoutQueryAsync(
            preCheckoutQueryId: String,
            ok: Bool,
            errorMessage: String? = nil,
            _ parameters: [String: Any?] = [:],
            queue: DispatchQueue = .main,
            completion: AnswerPreCheckoutQueryCompletion? = nil) {
        return requestAsync("answerPreCheckoutQuery", defaultParameters["answerPreCheckoutQuery"], parameters, [
            "pre_checkout_query_id": preCheckoutQueryId,
            "ok": ok,
            "error_message": errorMessage],
            queue: queue, completion: completion)
    }
}

