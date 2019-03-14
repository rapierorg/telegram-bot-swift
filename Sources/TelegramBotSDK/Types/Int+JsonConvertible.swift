//
// Int+JsonConvertible.swift
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


extension Int: JsonConvertible, InternalJsonConvertible {
    public init(json: Any) {
        self.init(internalJson: JSON(json))
    }

	internal init(internalJson: JSON) {
		self = internalJson.intValue
	}

    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
	
	internal var internalJson: JSON {
		get {
			return JSON(self)
		}
		set {
			self = newValue.intValue
		}
	}
}
