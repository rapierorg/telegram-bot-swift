// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// A venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultvenue>
public struct InlineQueryResultVenue: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}

