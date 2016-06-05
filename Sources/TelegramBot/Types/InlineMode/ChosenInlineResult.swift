// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// A result of an inline query that was chosen by the user and sent to their chat partner.
/// - SeeAlso: <https://core.telegram.org/bots/api#choseninlineresult>
public class ChosenInlineResult: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

