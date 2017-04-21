//
// ReplyKeyboardMarkup+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

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
