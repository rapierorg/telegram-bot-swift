//
// Video.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

// Represents a video file.
public class Video {

    /// Unique identifier for this file.
    public var fileId: String
    
    /// Video width as defined by sender.
    public var width: Int
    
    /// Video height as defined by sender.
    public var height: Int
    
    /// Duration of the video in seconds as defined by sender.
    public var duration: Int
    
    /// Video thumbnail.
    public var thumb: PhotoSize
    
    /// *Optional.* Mime type of a file as defined by sender.
    public var mimeType: String?
    
    /// *Optional.* File size.
    public var fileSize: Int?
    
    /// *Optional.* Text description of the video (usually empty).
    public var caption: String?
    
    /// Create an empty instance.
    public init() {
        fileId = ""
        width = 0
        height = 0
        duration = 0
        thumb = PhotoSize()
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
        
        guard let duration = json["duration"].int else { return nil }
        self.duration = duration
        
        guard let thumb = PhotoSize(json: json["thumb"]) else { return nil }
        self.thumb = thumb
        
        mimeType = json["mime_type"].string
        fileSize = json["file_size"].int
        caption = json["caption"].string
    }
    
    public var prettyPrint: String {
        var result = "Video(" +
            "  fileId: \(fileId)\n" +
            "  width: \(width)\n" +
            "  height: \(height)\n" +
            "  duration: \(duration)\n" +
            "  thumb: \(thumb.prettyPrint.indent().trim())\n"
        if let mimeType = mimeType {
            result += "  mimeType: \(mimeType)\n"
        }
        if let fileSize = fileSize {
            result += "  fileSize: \(fileSize)\n"
        }
        if let caption = caption {
            result += "  caption: \(caption)\n"
        }
        result += ")"
        return result
    }
}

extension Video: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Sticker(fileId: \(fileId), width: \(width), height: \(height), duration: \(duration), " +
            "thumb: \(thumb), mimeType: \(mimeType.unwrapAndPrint), fileSize: \(fileSize.unwrapAndPrint), " +
            "caption: \(caption.unwrapAndPrint))"
    }
}
