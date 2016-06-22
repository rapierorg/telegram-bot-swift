// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// A link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only pdf-files and zip archives can be sent using this method.
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultcacheddocument>
public struct InlineQueryResultCachedDocument: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}

