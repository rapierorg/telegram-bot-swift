// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot‘s message and tapped ’Reply').
public class ForceReply {
    
    /// Shows reply interface to the user, as if they manually selected the bot‘s message and tapped ’Reply'.
    public let forceReply = true
    
    /// *Optional.* Use this parameter if you want to force reply from specific users only.
    public var selective: Bool?
    
    /// Create an empty instance.
    public init() {
    }
    
    public var prettyPrint: String {
        return debugDescription
    }
}

extension ForceReply: CustomStringConvertible {
    public var description: String {
        var json = JSON([:])
        
        json["force_reply"].boolValue = forceReply

        if let selective = selective {
            json["selective"].boolValue = selective
        }
        return json.rawString(encoding: NSUTF8StringEncoding, options: []) ?? ""
    }
}

extension ForceReply: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "ForceReply(forceReply: \(forceReply), " +
        "selective: \(selective.unwrapOptional))"
    }
}
