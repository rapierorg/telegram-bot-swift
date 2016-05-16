// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a group chat.
public class GroupChat: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Unique identifier for this group chat.
	public var id: Int {
		get { return json["id"].intValue }
		set { json["id"].intValue = newValue }
	}
		
    /// Group name.
	public var title: String {
		get { return json["title"].stringValue }
		set { json["title"].stringValue = newValue }
	}
		
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}

