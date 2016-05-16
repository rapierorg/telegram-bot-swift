//
// GroupChat.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a group chat.
public class GroupChat: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Unique identifier for this group chat.
    public var id: Int
    
    /// Group name.
    public var title: String
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        id = 0
        title = ""
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(_ json: JSON) {
        self.init()
		self.json = json

        if json.isNullOrUnknown { return nil }
        
        guard let id = json["id"].int else { return nil }
        self.id = id
        
        guard let title = json["title"].string else { return nil }
        self.title = title
    }
}

