//
// Audio.swift
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

// Represents an audio file (voice note).
public class Audio {
    
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
}

extension Audio: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Audio(fileId: \(fileId), duration: \(duration), mimeType: \(mimeType), fileSize: \(fileSize))"
    }
}
