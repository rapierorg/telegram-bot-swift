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
public class /*NS*/Document {
    
    /// Unique file identifier.
    public var fileId: String
    
    /// Document thumbnail as defined by sender.
    public var thumb: /*NS*/PhotoSize
    
    /// *Optional.* Original filename as defined by sender.
    public var fileName: String?
    
    /// *Optional.* MIME type of the file as defined by sender.
    public var mimeType: String?
    
    /// *Optional.* File size.
    public var fileSize: Int?
    
    /// Create an empty instance.
    public init() {
        fileId = ""
        thumb = /*NS*/PhotoSize()
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let fileId = json["file_id"].string else { return nil }
        self.fileId = fileId
        
        guard let thumb = /*NS*/PhotoSize(json: json["thumb"]) else { return nil }
        self.thumb = thumb
        
        fileName = json["file_name"].string
        mimeType = json["mime_type"].string
        fileSize = json["file_size"].int
    }
    
    public var prettyPrint: String {
        var result = "Document(" +
            "  fileId: \(fileId)\n" +
            "  thumb: \(thumb.prettyPrint.indent().trim())\n"
        if let fileName = fileName {
            result += "  fileName=\(fileName)\n"
        }
        if let mimeType = mimeType {
            result += "  mimeType=\(mimeType)\n"
        }
        if let fileSize = fileSize {
            result += "  fileSize=\(fileSize)\n"
        }
        result += ")"
        return result
    }
}

extension /*NS*/Document: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Document(fileId: \(fileId), thumb: \(thumb), fileName: \(fileName.unwrapAndPrint), " +
            "mimeType: \(mimeType.unwrapAndPrint), fileSize: \(fileSize.unwrapAndPrint))"
    }
}
