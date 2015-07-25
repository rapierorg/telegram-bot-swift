//
//  Document.swift
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

/// Represents a general file (as opposed to photos and audio files).
public class Document {
    
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
        fileId = ""
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
        
        guard let thumb = PhotoSize(json: json["thumb"]) else { return nil }
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

extension Document: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Document(fileId: \(fileId), thumb: \(thumb), fileName: \(fileName.unwrapAndPrint), " +
            "mimeType: \(mimeType.unwrapAndPrint), fileSize: \(fileSize.unwrapAndPrint))"
    }
}
