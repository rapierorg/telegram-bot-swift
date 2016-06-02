// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represent a user's profile pictures.
/// - SeeAlso: <https://core.telegram.org/bots/api#userprofilephotos>
public class UserProfilePhotos: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Total number of profile pictures the target user has.
	public var total_count: Int {
		get { return json["total_count"].intValue }
		set { json["total_count"].intValue = newValue }
	}
	
	/// Requested profile pictures (in up to 4 sizes each).
	public var photos: [[PhotoSize]] {
		get {
			return json["photos"].twoDArrayValue()
		}
		set {
			//json["photos"] = JSON(newValue)
			var rowsJson = [JSON]()
			rowsJson.reserveCapacity(newValue.count)
			for row in newValue {
				var colsJson = [JSON]()
				colsJson.reserveCapacity(row.count)
				for col in row {
					let json = col.json
					colsJson.append(json)
				}
				rowsJson.append(JSON(colsJson))
			}
			json["photos"] = JSON(rowsJson)
		}
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

