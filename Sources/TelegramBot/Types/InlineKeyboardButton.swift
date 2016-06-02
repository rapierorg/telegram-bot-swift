// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents one button of an inline keyboard. You must use exactly one of the optional fields..
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinekeyboardbutton>
public class InlineKeyboardButton: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Label text on the button.
	public var text: String {
		get { return json["text"].stringValue }
		set { json["text"].stringValue = newValue }
	}
	
	/// *Optional.* HTTP url to be opened when button is pressed.
	public var url: String? {
		get { return json["url"].string }
		set { json["url"].string = newValue }
	}
	
	/// *Optional.* Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes.
	public var callback_data: String? {
		get { return json["callback_data"].string }
		set { json["callback_data"].string = newValue }
	}
	
	/// *Optional.* Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot‘s username and the specified inline query in the input field. Can be empty, in which case just the bot’s username will be inserted.
	public var switch_inline_query: String? {
		get { return json["switch_inline_query"].string }
		set { json["switch_inline_query"].string = newValue }
	}
		
	public required init(json: JSON = [:]) {
		self.json = json
	}
}
