// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a chat.
public class Chat: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Unique identifier for this chat, not exceeding 1e13 by absolute value
	public var id: Int {
		get { return json["id"].intValue }
		set { json["id"].intValue = newValue }
	}
	
	/// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	public var typeString: String {
		get { return json["type"].stringValue }
		set { json["type"].stringValue = newValue }
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
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}

