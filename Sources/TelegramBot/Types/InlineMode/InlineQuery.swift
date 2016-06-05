// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// An incoming inline query. When the user sends an empty query, your bot could return some default or trending results.
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequery>
public class InlineQuery: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

