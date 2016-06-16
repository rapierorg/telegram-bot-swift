// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a chat.
/// - SeeAlso: <https://core.telegram.org/bots/api#chat>
public struct Chat: JsonObject {
	public enum ChatType: String {
		case private_chat = "private"
		case group = "group"
		case supergroup = "supergroup"
		case channel = "channel"
		case unknown = ""
	}
	
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Unique identifier for this chat (52 bits are used)
	public var id: Int64 {
		get { return json["id"].int64Value }
		set { json["id"].int64Value = newValue }
	}
	
	/// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	public var typeString: String {
		get { return json["type"].stringValue }
		set { json["type"].stringValue = newValue }
	}

	/// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	public var type: ChatType {
		get { return ChatType(rawValue: typeString) ?? .unknown }
		set { typeString = newValue.rawValue }
	}

	/// *Optional.* Title, for channels and group chats
	public var title: String? {
		get { return json["title"].string }
		set { json["title"].string = newValue }
	}
	
	/// *Optional.* Username, for private chats and channels if available
	public var username: String? {
		get { return json["username"].string }
		set { json["username"].string = newValue }
	}
	
	/// *Optional.* First name of the other party in a private chat
	public var first_name: String {
		get { return json["first_name"].stringValue }
		set { json["first_name"].stringValue = newValue }
	}
	
	/// *Optional.* Last name of the other party in a private chat
	public var last_name: String? {
		get { return json["last_name"].string }
		set { json["last_name"].string = newValue }
	}
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}

