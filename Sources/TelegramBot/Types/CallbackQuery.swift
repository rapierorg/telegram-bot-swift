// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be presented. If the button was attached to a message sent via the bot (in inline mode), the field inline_message_id will be presented.
/// - SeeAlso: <https://core.telegram.org/bots/api#callbackquery>
public struct CallbackQuery: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures.
	public var json: JSON

	/// Unique identifier for this query.
	public var id: String {
		get { return json["id"].stringValue }
		set { json["id"].stringValue = newValue }
	}
	
	/// Sender.
	public var from: User {
		get { return User(json: json["from"]) }
		set { json["from"] = newValue.json }
	}
	
	/// *Optional.* Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old.
	public var message: Message? {
		get {
			let value = json["message"]
			return value.isNullOrUnknown ? nil : Message(json: value)
		}
		set {
			json["message"] = newValue?.json ?? nil
		}
	}
	
	/// *Optional.* Identifier of the message sent via the bot in inline mode, that originated the query.
	public var inline_message_id: String? {
		get { return json["inline_message_id"].string }
		set { json["inline_message_id"].string = newValue }
	}
	
	/// *Optional.* Data associated with the callback button. Be aware that a bad client can send arbitrary data in this field.
	public var data: String? {
		get { return json["data"].string }
		set { json["data"].string = newValue }
	}
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}

