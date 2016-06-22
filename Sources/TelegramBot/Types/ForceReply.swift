// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot‘s message and tapped ’Reply'). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode.
/// - SeeAlso: <https://core.telegram.org/bots/api#forcereply>
public struct ForceReply: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

	/// Shows reply interface to the user, as if they manually selected the bot‘s message and tapped ’Reply'.
	public var force_reply: Bool {
		get { return json["force_reply"].boolValue }
		set { json["force_reply"].boolValue = newValue }
	}
	
	/// Optional. Use this parameter if you want to force reply from specific users only.
	public var selective: Bool {
		get { return json["selective"].boolValue }
		set { json["selective"].boolValue = newValue }
	}
	
	public init(json: JSON = ["force_reply": true]) {
		self.json = json
	}
}
