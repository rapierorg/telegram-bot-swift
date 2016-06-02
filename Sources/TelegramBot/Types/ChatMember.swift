// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON


/// Contains information about one member of the chat.
/// - SeeAlso: <https://core.telegram.org/bots/api#chatmember>
public class ChatMember: JsonObject {
	public enum Status: String {
		case creator = "creator"
		case administrator = "administrator"
		case member = "member"
		case left = "left"
		case kicked = "kicked"
		case unknown = ""
	}
	
	/// Original JSON for fields not yet added to Swift structures.
	public var json: JSON
	
	/// Information about the user.
	public var user: User {
		get { return User(json: json["user"]) }
		set { json["user"] = newValue.json }
	}
	
	/// The member's status in the chat. Can be “creator”, “administrator”, “member”, “left” or “kicked”.
	public var statusString: String {
		get { return json["status"].stringValue }
		set { json["status"].stringValue = newValue }
	}
	
	/// The member's status in the chat. Can be “creator”, “administrator”, “member”, “left” or “kicked”.
	public var status: Status {
		get { return Status(rawValue: statusString) ?? .unknown }
		set { statusString = newValue.rawValue }
	}
}

	