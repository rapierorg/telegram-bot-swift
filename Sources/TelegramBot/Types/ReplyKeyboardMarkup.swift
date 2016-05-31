// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a custom keyboard with reply options.
public class ReplyKeyboardMarkup: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Array of button rows, each represented by an Array of Strings.
	public var keyboardStrings: [[String]] {
		get {
			let keyboardJson = json["keyboard"].arrayValue
			var result = [[String]]()
			result.reserveCapacity(keyboardJson.count)
			for rowJson in keyboardJson {
				var row = [String]()
				row.reserveCapacity(rowJson.count)
				for columnJson in rowJson.arrayValue {
					row.append(columnJson.stringValue)
				}
				result.append(row)
			}
			return result
		}
		set {
			var rowsJson = [JSON]()
			rowsJson.reserveCapacity(newValue.count)
			for row in newValue {
				let rowJson = JSON(row)
				rowsJson.append(rowJson)
			}
			json["keyboard"] = JSON(rowsJson)
		}
	}
	
//	public var keyboardButtons: [[KeyboardButton]] {
//		get {
//			
//		}
//		set {
//			
//		}
//	}

    /// *Optional.* Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
	public var resize_keyboard: Bool? {
		get { return json["resize_keyboard"].bool }
		set { json["resize_keyboard"].bool = newValue }
	}
	
    /// Optional. Requests clients to hide the keyboard as soon as it's been used. Defaults to false.
	public var one_time_keyboard: Bool? {
		get { return json["one_time_keyboard"].bool }
		set { json["one_time_keyboard"].bool = newValue }
	}
	
    /// Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
	public var selective: Bool? {
		get { return json["selective"].bool }
		set { json["selective"].bool = newValue }
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

