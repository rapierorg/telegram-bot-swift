//
// ReplyKeyboardHide.swift
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
