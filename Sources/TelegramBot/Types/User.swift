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
    public var id: Int
    
    /// User‘s or bot’s first name.
    public var firstName: String
    
    /// *Optional.* User‘s or bot’s last name.
    public var lastName: String?
    
    /// *Optional.* User‘s or bot’s username.
    public var username: String?
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        id = 0
        firstName = ""
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
		self.json = json
        
        if json.isNullOrUnknown { return nil }
        
        guard let id = json["id"].int else { return nil }
        self.id = id
        
        guard let firstName = json["first_name"].string else { return nil }
        self.firstName = firstName
        
        lastName = json["last_name"].string
        username = json["username"].string
    }
}

