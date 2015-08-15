//
// Update.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents an incoming update.
public class /*NS*/Update {

    /// The update‘s unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you’re using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order.
    public var updateId: Int
    
    /// *Optional.* New incoming message of any kind — text, photo, sticker, etc.
    public var message: /*NS*/Message?
    
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
        
        message = /*NS*/Message(json: json["message"])
    }
    
    public var prettyPrint: String {
        var result = "Update(\n" +
            "  updateId: \(updateId)\n"
        if let message = message {
            result += "  message: \(message.prettyPrint.indent().trim())\n"
        }
        result += ")"
        return result
    }
}

extension /*NS*/Update: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Update(updateId: \(updateId), message: \(message.unwrapAndPrint))"
    }
}
