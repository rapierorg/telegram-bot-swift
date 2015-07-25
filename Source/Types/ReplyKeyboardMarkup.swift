//
// ReplyKeyboardMarkup.swift
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

/// Represents a custom keyboard with reply options.
public class ReplyKeyboardMarkup {

    /// Array of button rows, each represented by an Array of Strings.
    var keyboard: [[String]]

    /// *Optional.* Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
    var resizeKeyboard: Bool?
    
    /// Optional. Requests clients to hide the keyboard as soon as it's been used. Defaults to false.
    var oneTimeKeyboard: Bool?
    
    /// Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
    var selective: Bool?
    
    /// Create an empty instance.
    public init() {
        keyboard = [[]]
    }
    
    public var prettyPrint: String {
        return debugDescription
    }
}

extension ReplyKeyboardMarkup: CustomStringConvertible {
    public var description: String {
        var json = JSON([:])
        
        var keyboardJSON = JSON([])
        for row in keyboard {
            let rowJSON = JSON(row)
            // SwiftyJSON's array has no append
            keyboardJSON = JSON(keyboardJSON.arrayObject! + [rowJSON.arrayObject!])
        }
        json["keyboard"] = keyboardJSON
        
        if let resizeKeyboard = resizeKeyboard {
            json["resize_keyboard"].boolValue = resizeKeyboard
        }
        if let oneTimeKeyboard = oneTimeKeyboard {
            json["one_time_keyboard"].boolValue = oneTimeKeyboard
        }
        if let selective = selective {
            json["selective"].boolValue = selective
        }
        return json.rawString(NSUTF8StringEncoding, options: []) ?? ""
    }
}

extension ReplyKeyboardMarkup: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "ReplyKeyboardMarkup(keyboard: \(keyboard), resizeKeyboard: \(resizeKeyboard.unwrapAndPrint), " +
            "oneTimeKeyboard: \(oneTimeKeyboard.unwrapAndPrint), selective: \(selective.unwrapAndPrint))"
    }
}
