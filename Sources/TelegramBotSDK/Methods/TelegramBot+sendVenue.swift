// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import Dispatch

public extension TelegramBot {
    typealias SendVenueCompletion = (_ result: Message?, _ error: DataTaskError?) -> ()

    /// Use this method to send information about a venue. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - latitude: Latitude of the venue
    ///     - longitude: Longitude of the venue
    ///     - title: Name of the venue
    ///     - address: Address of the venue
    ///     - foursquare_id: Foursquare identifier of the venue
    ///     - disable_notification: Sends the message silently. Users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
    @discardableResult
    public func sendVenueSync(
            chatId: ChatId,
            latitude: Float,
            longitude: Float,
            title: String,
            address: String,
            foursquareId: String? = nil,
            disableNotification: Bool? = nil,
            replyToMessageId: Int? = nil,
            replyMarkup: ReplyMarkup? = nil,
            _ parameters: [String: Any?] = [:]) -> Message? {
        return requestSync("sendVenue", defaultParameters["sendVenue"], parameters, [
            "chat_id": chatId,
            "latitude": latitude,
            "longitude": longitude,
            "title": title,
            "address": address,
            "foursquare_id": foursquareId,
            "disable_notification": disableNotification,
            "reply_to_message_id": replyToMessageId,
            "reply_markup": replyMarkup])
    }

    /// Use this method to send information about a venue. On success, the sent Message is returned.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - latitude: Latitude of the venue
    ///     - longitude: Longitude of the venue
    ///     - title: Name of the venue
    ///     - address: Address of the venue
    ///     - foursquare_id: Foursquare identifier of the venue
    ///     - disable_notification: Sends the message silently. Users will receive a notification with no sound.
    ///     - reply_to_message_id: If the message is a reply, ID of the original message
    ///     - reply_markup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
    /// - Returns: Message on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendvenue>
    public func sendVenueAsync(
            chatId: ChatId,
            latitude: Float,
            longitude: Float,
            title: String,
            address: String,
            foursquareId: String? = nil,
            disableNotification: Bool? = nil,
            replyToMessageId: Int? = nil,
            replyMarkup: ReplyMarkup? = nil,
            _ parameters: [String: Any?] = [:],
            queue: DispatchQueue = .main,
            completion: SendVenueCompletion? = nil) {
        return requestAsync("sendVenue", defaultParameters["sendVenue"], parameters, [
            "chat_id": chatId,
            "latitude": latitude,
            "longitude": longitude,
            "title": title,
            "address": address,
            "foursquare_id": foursquareId,
            "disable_notification": disableNotification,
            "reply_to_message_id": replyToMessageId,
            "reply_markup": replyMarkup],
            queue: queue, completion: completion)
    }
}

