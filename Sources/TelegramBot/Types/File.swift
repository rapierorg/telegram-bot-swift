// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a file ready to be downloaded.
/// - SeeAlso: <https://core.telegram.org/bots/api#file>
public struct File: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// Unique file identifier.
	public var file_id: String {
		get { return json["file_id"].stringValue }
		set { json["file_id"].stringValue = newValue }
	}
	
	/// *Optional.* File size.
	public var file_size: Int? {
		get { return json["file_size"].int }
		set { json["file_size"].int = newValue }
	}
	
	/// *Optional.* File path.
	public var file_path: String? {
		get { return json["file_path"].string }
		set { json["file_path"].string = newValue }
	}

	public init(json: JSON = [:]) {
		self.json = json
	}
}
