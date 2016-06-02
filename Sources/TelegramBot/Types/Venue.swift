// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a venue..
/// - SeeAlso: <https://core.telegram.org/bots/api#venue>
public class Venue: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Venue location.
	public var location: Location {
		get {
			let value = json["location"]
			return Location(json: value.isNullOrUnknown ? [:] : value)
		}
		set {
			json["location"] = newValue.json
		}
	}
	
	/// Name of the venue.
	public var title: String {
		get { return json["title"].stringValue }
		set { json["title"].stringValue = newValue }
	}

	/// Address of the venue.
	public var address: String {
		get { return json["address"].stringValue }
		set { json["address"].stringValue = newValue }
	}
	
	/// *Optional.* Foursquare identifier of the venue.
	public var foursquare_id: String? {
		get { return json["foursquare_id"].string }
		set { json["foursquare_id"].string = newValue }
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

