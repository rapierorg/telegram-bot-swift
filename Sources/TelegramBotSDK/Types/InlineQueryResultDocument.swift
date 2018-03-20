// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import SwiftyJSON

/// Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultdocument>

public struct InlineQueryResultDocument: JsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: JSON

    /// Type of the result, must be document
    public var typeString: String {
        get { return json["type"].stringValue }
        set { json["type"].stringValue = newValue }
    }

    /// Unique identifier for this result, 1-64 bytes
    public var id: String {
        get { return json["id"].stringValue }
        set { json["id"].stringValue = newValue }
    }

    /// Title for the result
    public var title: String {
        get { return json["title"].stringValue }
        set { json["title"].stringValue = newValue }
    }

    /// Optional. Caption of the document to be sent, 0-200 characters
    public var caption: String? {
        get { return json["caption"].string }
        set { json["caption"].string = newValue }
    }

    /// Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    public var parseMode: String? {
        get { return json["parse_mode"].string }
        set { json["parse_mode"].string = newValue }
    }

    /// A valid URL for the file
    public var documentUrl: String {
        get { return json["document_url"].stringValue }
        set { json["document_url"].stringValue = newValue }
    }

    /// Mime type of the content of the file, either “application/pdf” or “application/zip”
    public var mimeType: String {
        get { return json["mime_type"].stringValue }
        set { json["mime_type"].stringValue = newValue }
    }

    /// Optional. Short description of the result
    public var description: String? {
        get { return json["description"].string }
        set { json["description"].string = newValue }
    }

    /// Optional. Inline keyboard attached to the message
    public var replyMarkup: InlineKeyboardMarkup? {
        get {
            let value = json["reply_markup"]
            return value.isNullOrUnknown ? nil : InlineKeyboardMarkup(json: value)
        }
        set {
            json["reply_markup"] = newValue?.json ?? JSON.null
        }
    }

    /// Optional. Content of the message to be sent instead of the file
    public var inputMessageContent: InputMessageContent? {
        get {
            fatalError("Not implemented")
        }
        set {
            json["input_message_content"] = newValue?.json ?? JSON.null
        }
    }

    /// Optional. URL of the thumbnail (jpeg only) for the file
    public var thumbUrl: String? {
        get { return json["thumb_url"].string }
        set { json["thumb_url"].string = newValue }
    }

    /// Optional. Thumbnail width
    public var thumbWidth: Int? {
        get { return json["thumb_width"].int }
        set { json["thumb_width"].int = newValue }
    }

    /// Optional. Thumbnail height
    public var thumbHeight: Int? {
        get { return json["thumb_height"].int }
        set { json["thumb_height"].int = newValue }
    }

    public init(json: JSON = [:]) {
        self.json = json
    }
}
