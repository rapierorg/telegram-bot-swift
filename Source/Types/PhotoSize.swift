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
public class PhotoSize {
    
    /// Unique identifier for this file.
    public var fileId: String
    
    /// Photo width.
    public var width: Int
    
    /// Photo height.
    public var height: Int
    
    /// *Optional.* File size.
    public var fileSize: Int?
    
    /// Create an empty instance.
    public init() {
        fileId = ""
        width = 0
        height = 0
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let fileId = json["file_id"].string else { return nil }
        self.fileId = fileId
        
        guard let width = json["width"].int else { return nil }
        self.width = width
        
        guard let height = json["height"].int else { return nil }
        self.height = height
        
        fileSize = json["file_size"].int
    }
    
    public var prettyPrint: String {
        var result = "PhotoSize(\n" +
            "  fileId: \(fileId)\n"
            "  width: \(width)\n"
            "  height: \(height)\n"
        if let fileSize = fileSize {
            result += "  fileSize: \(fileSize)\n"
        }
        result += ")"
        return result
    }
}

extension PhotoSize: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "PhotoSize(fileId: \(fileId), width: \(width), height: \(height), fileSize: \(fileSize.unwrapAndPrint))"
    }
}