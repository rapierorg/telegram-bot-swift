//
// GroupChat.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a group chat.
public class GroupChat {
    
    /// Unique identifier for this group chat.
    public var id: Int
    
    /// Group name.
    public var title: String
    
    /// Create an empty instance.
    public init() {
        id = 0
        title = ""
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let id = json["id"].int else { return nil }
        self.id = id
        
        guard let title = json["title"].string else { return nil }
        self.title = title
    }
    
    public var prettyPrint: String {
        return "GroupChat(\n" +
            "  id: \(id)\n" +
            "  title: \(title)\n" +
        ")"
    }
}

extension GroupChat: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "GroupChat(id: \(id), title: \(title))"
    }
}
