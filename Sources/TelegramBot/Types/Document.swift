//
// Document.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a general file (as opposed to photos and audio files).
public class Document: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Unique file identifier.
    public var fileId: String
    
    /// Document thumbnail as defined by sender.
    public var thumb: PhotoSize
    
    /// *Optional.* Original filename as defined by sender.
    public var fileName: String?
    
    /// *Optional.* MIME type of the file as defined by sender.
    public var mimeType: String?
    
    /// *Optional.* File size.
    public var fileSize: Int?
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        fileId = ""
        thumb = PhotoSize()
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
		self.json = json

        if json.isNullOrUnknown { return nil }
        
        guard let fileId = json["file_id"].string else { return nil }
        self.fileId = fileId
        
        guard let thumb = PhotoSize(json: json["thumb"]) else { return nil }
        self.thumb = thumb
        
        fileName = json["file_name"].string
        mimeType = json["mime_type"].string
        fileSize = json["file_size"].int
    }
}
