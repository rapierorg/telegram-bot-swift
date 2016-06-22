// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Upon receiving a message with this object, Telegram clients will hide the current custom keyboard and display the default letter-keyboard.
/// - SeeAlso: <https://core.telegram.org/bots/api#replykeyboardhide>
public struct ReplyKeyboardHide: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures.
	public var json: JSON
	
	/// *Optional.* Requests clients to hide the custom keyboard.
	public var hide_keyboard: Bool {
		get { return json["hide_keyboard"].boolValue }
		set { json["hide_keyboard"].boolValue = newValue }
	}
	
    /// *Optional.* Use this parameter if you want to hide keyboard for specific users only.
	public var selective: Bool {
		get { return json["selective"].boolValue }
		set { json["selective"].boolValue = newValue }
	}
	
	public init(json: JSON = ["hide_keyboard": true]) {
		self.json = json
	}
}
