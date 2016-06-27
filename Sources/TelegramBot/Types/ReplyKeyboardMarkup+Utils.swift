// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

extension ReplyKeyboardMarkup {
    /// Array of button rows, each represented by an Array of Strings
    public var keyboard_strings: [[String]] {
        get {
            return json["keyboard"].twoDArrayValue()
        }
        set {
            json["keyboard"] = JSON(newValue)
        }
    }
}
