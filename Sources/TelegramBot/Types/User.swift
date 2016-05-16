//
// User.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a Telegram user or bot.
public class User: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Unique identifier for this user or bot.
	public var id: Int {
		get { return json["id"].intValue }
		set { json["id"].intValue = newValue }
	}
		
    /// User‘s or bot’s first name.
	public var first_name: String {
		get { return json["first_name"].stringValue }
		set { json["first_name"].stringValue = newValue }
	}
		
    /// *Optional.* User‘s or bot’s last name.
	public var last_name: String? {
		get { return json["last_name"].string }
		set { json["last_name"].string = newValue }
	}
		
    /// *Optional.* User‘s or bot’s username.
	public var username: String? {
		get { return json["username"].string }
		set { json["username"].string = newValue }
	}
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}

