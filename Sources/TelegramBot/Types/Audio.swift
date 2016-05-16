//
// Audio.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

// Represents an audio file (voice note).
public class Audio: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
    
    /// Unique identifier for this file.
    public var fileId: String
    
    /// Duration of the audio in seconds as defined by sender.
    public var duration: Int
    
    /// *Optional.* MIME type of the file as defined by sender.
    public var mimeType: String?
    
    /// *Optional.* File size.
    public var fileSize: Int?
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        fileId = ""
        duration = 0
    }

    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(_ json: JSON) {
        self.init()
		self.json = json

        if json.isNullOrUnknown { return nil }

        guard let fileId = json["file_id"].string else { return nil }
        self.fileId = fileId
        
        guard let duration = json["duration"].int else { return nil }
        self.duration = duration
        
        mimeType = json["mime_type"].string
        fileSize = json["file_size"].int
    }
}

