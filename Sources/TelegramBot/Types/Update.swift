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
	public var update_id: Int {
		get { return json["update_id"].intValue }
		set { json["update_id"].intValue = newValue }
	}
		
    /// *Optional.* New incoming message of any kind — text, photo, sticker, etc.
	public var message: Message? {
		get {
			let value = json["message"]
			return value.isNullOrUnknown ? nil : Message(value)
		}
		set {
			json["message"] = newValue?.json ?? nil
		}
	}
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}
