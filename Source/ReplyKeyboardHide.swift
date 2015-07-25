//
// ReplyKeyboardHide.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Upon receiving a message with this object, Telegram clients will hide the current custom keyboard and display the default letter-keyboard.
public class ReplyKeyboardHide {

    /// Requests clients to hide the custom keyboard.
    let hideKeyboard = true
    
    /// *Optional.* Use this parameter if you want to hide keyboard for specific users only.
    var selective: Bool?
    
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
        return json.rawString(NSUTF8StringEncoding, options: []) ?? ""
    }
}

extension ReplyKeyboardHide: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "ReplyKeyboardHide(hideKeyboard: \(hideKeyboard), " +
            "selective: \(selective.unwrapAndPrint))"
    }
}
