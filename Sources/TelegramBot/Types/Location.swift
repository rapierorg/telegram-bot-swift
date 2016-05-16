// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

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
