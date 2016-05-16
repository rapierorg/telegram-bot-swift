//
// PhotoSize.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents one size of a photo or a file / sticker thumbnail.
public class PhotoSize: JsonObject {
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
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}
