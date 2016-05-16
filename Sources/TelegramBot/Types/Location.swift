//
// Location.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a point on the map.
public class Location: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Longitude as defined by sender.
	public var longitude: Float {
		get { return json["longitude"].floatValue }
		set { json["longitude"].floatValue = newValue }
	}
		
    /// Latitude as defined by sender.
	public var latitude: Float {
		get { return json["latitude"].floatValue }
		set { json["latitude"].floatValue = newValue }
	}
		
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}
