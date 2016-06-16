// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents an inline keyboard that appears right next to the message it belongs to.
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinekeyboardmarkup>
public struct InlineKeyboardMarkup: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Array of button rows, each represented by an Array of InlineKeyboardButton objects.
	public var inline_keyboard: [[InlineKeyboardButton]] {
		get {
			return json["inline_keyboard"].twoDArrayValue()
		}
		set {
			//json["inline_keyboard"] = JSON(newValue)
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
			json["inline_keyboard"] = JSON(rowsJson)
		}
	}
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}

