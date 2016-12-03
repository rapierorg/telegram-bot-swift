//
// Int64+JsonConvertible.swift
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

extension Int64: JsonConvertible {
    public init(json: JSON) {
        self = json.int64Value
    }
    
    public var json: JSON {
        get {
            return JSON(Double(self))
        }
        set {
            self = newValue.int64Value
        }
    }
}
