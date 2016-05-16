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

