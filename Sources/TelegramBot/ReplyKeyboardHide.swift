// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Upon receiving a message with this object, Telegram clients will hide the current custom keyboard and display the default letter-keyboard.
public class ReplyKeyboardHide {

    /// Requests clients to hide the custom keyboard.
    public let hideKeyboard = true
    
    /// *Optional.* Use this parameter if you want to hide keyboard for specific users only.
    public var selective: Bool?
    
    /// Create an empty instance.
    public init() {
    }
    
    public var prettyPrint: String {
        return debugDescription
    }
}

extension ReplyKeyboardHide: CustomStringConvertible {
    public var description: String {
        var json = JSON([:])
        
        json["hide_keyboard"].boolValue = hideKeyboard

        if let selective = selective {
            json["selective"].boolValue = selective
        }
        return json.rawString(encoding: NSUTF8StringEncoding, options: []) ?? ""
    }
}

extension ReplyKeyboardHide: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "ReplyKeyboardHide(hideKeyboard: \(hideKeyboard), " +
            "selective: \(selective.unwrapOptional))"
    }
}
