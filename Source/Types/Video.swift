//
// Video.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
}

extension Video: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Sticker(fileId: \(fileId), width: \(width), height: \(height), duration: \(duration), " +
            "thumb: \(thumb), mimeType: \(mimeType.prettyPrint), fileSize: \(fileSize.prettyPrint), " +
            "caption: \(caption.prettyPrint))"
    }
}
