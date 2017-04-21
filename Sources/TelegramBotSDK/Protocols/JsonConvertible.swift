//
// JsonConvertible.swift
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

public protocol JsonConvertible: CustomStringConvertible, CustomDebugStringConvertible {
	init(json: JSON)
	var json: JSON { get set }
	func prettyPrint()
}

extension JsonConvertible {
	public var description: String {
		return json.rawString() ?? ""
	}
	
	public var debugDescription: String {
		return json.debugDescription
	}
	
	public func prettyPrint() {
		json.prettyPrint()
	}
}
