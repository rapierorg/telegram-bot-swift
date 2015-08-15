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
public class /*NS*/Audio {
    
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
        fileId = ""
        duration = 0
    }

    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }

        guard let fileId = json["file_id"].string else { return nil }
        self.fileId = fileId
        
        guard let duration = json["duration"].int else { return nil }
        self.duration = duration
        
        mimeType = json["mime_type"].string
        fileSize = json["file_size"].int
    }
    
    public var prettyPrint: String {
        var result = "Audio(\n" +
            "  fileId: \(fileId)\n" +
            "  duration: \(duration)\n"
        if let mimeType = mimeType {
            result += "  mimeType: \(mimeType)\n"
        }
        if let fileSize = fileSize {
            result += "  fileSize: \(fileSize)\n"
        }
        result += ")"
        return result
    }
}

extension /*NS*/Audio: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Audio(fileId: \(fileId), duration: \(duration), " +
            "mimeType: \(mimeType.unwrapAndPrint), fileSize: \(fileSize.unwrapAndPrint))"
    }
}
