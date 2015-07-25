//
// Update.swift
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

/// Represents an incoming update.
public class Update {

    /// The update‘s unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you’re using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order.
    var updateId: Int
    
    /// *Optional.* New incoming message of any kind — text, photo, sticker, etc.
    var message: Message?
    
    /// Create an empty instance.
    public init() {
        updateId = 0
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let updateId = json["update_id"].int else { return nil }
        self.updateId = updateId
        
        message = Message(json: json["message"])
    }
    
    public var prettyPrint: String {
        var result = "Update(\n"
            "  updateId: \(updateId)\n"
        if let message = message {
            result += "  message: \(message.prettyPrint.indent().trim())\n"
        }
        result += ")"
        return result
    }
}

extension Update: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Update(updateId: \(updateId), message: \(message.unwrapAndPrint))"
    }
}
