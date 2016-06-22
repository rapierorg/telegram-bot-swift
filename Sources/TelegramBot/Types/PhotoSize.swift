// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents one size of a photo or a file / sticker thumbnail.
/// - SeeAlso: <https://core.telegram.org/bots/api#photosize>
public struct PhotoSize: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Unique identifier for this file.
	public var file_id: String {
		get { return json["file_id"].stringValue }
		set { json["file_id"].stringValue = newValue }
	}
		
    /// Photo width.
	public var width: Int {
		get { return json["width"].intValue }
		set { json["width"].intValue = newValue }
	}
		
    /// Photo height.
    public var height: Int {
		get { return json["height"].intValue }
		set { json["height"].intValue = newValue }
	}
	
    /// *Optional.* File size.
    public var file_size: Int? {
		get { return json["file_size"].int }
		set { json["file_size"].int = newValue }
	}
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}
