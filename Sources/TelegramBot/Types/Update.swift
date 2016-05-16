//
// Update.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents an incoming update.
public class Update: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// The update‘s unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you’re using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order.
    public var updateId: Int
    
    /// *Optional.* New incoming message of any kind — text, photo, sticker, etc.
    public var message: Message?
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        updateId = 0
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(_ json: JSON) {
        self.init()
		self.json = json
        
        if json.isNullOrUnknown { return nil }
        
        guard let updateId = json["update_id"].int else { return nil }
        self.updateId = updateId
        
        message = Message(json: json["message"])
    }
}

