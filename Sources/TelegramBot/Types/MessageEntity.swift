// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON


/// Represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.
/// - SeeAlso: <https://core.telegram.org/bots/api#messageentity>
public class MessageEntity: JsonObject {
	public enum MessageEntityType: String {
		case mention = "mention"
		case hashtag = "hashtag"
		case bot_command = "bot_command"
		case url = "url"
		case email = "email"
		case bold = "bold"
		case italic = "italic"
		case code = "code"
		case pre = "pre"
		case text_link = "text_link"
		case text_mention = "text_mention"
		case unknown = ""
	}
	
	/// Original JSON for fields not yet added to Swift structures.
	public var json: JSON

	/// Type of the entity. Can be mention (@username), hashtag, bot_command, url, email, bold (bold text), italic (italic text), code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
	public var typeString: String {
		get { return json["type"].stringValue }
		set { json["type"].stringValue = newValue }
	}
	
	/// Type of the entity. Can be mention (@username), hashtag, bot_command, url, email, bold (bold text), italic (italic text), code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
	public var type: MessageEntityType {
		get { return MessageEntityType(rawValue: typeString) ?? .unknown }
		set { typeString = newValue.rawValue }
	}
	
	/// Offset in UTF-16 code units to the start of the entity.
	public var offset: Int {
		get { return json["offset"].intValue }
		set { json["offset"].intValue = newValue }
	}
	
	/// Length of the entity in UTF-16 code units.
	public var length: Int {
		get { return json["length"].intValue }
		set { json["length"].intValue = newValue }
	}
	
	/// *Optional.* For “text_link” only, url that will be opened after user taps on the text.
	public var url: String? {
		get { return json["url"].string }
		set { json["url"].string = newValue }
	}
	
	/// *Optional.* For “text_mention” only, the mentioned user.
	public var user: User {
		get { return User(json: json["user"]) }
		set { json["user"] = newValue.json }
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

	