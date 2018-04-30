//
// JSON+Utils.Swift
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


extension JSON {
    /// - Returns: True if json is empty or of unknown type
    public var isNullOrUnknown: Bool {
        return type == .null || type == .unknown
    }
	
	/// Print with indentation.
	public func prettyPrint() {
		print(debugDescription)
	}
	
    // This doesn't work:
    // https://bugs.swift.org/browse/SR-2504
    // https://bugs.swift.org/browse/SR-2505
    //init<T>(_ from: [T]) where T: JsonConvertible {
    // Workaround:
    static func initFrom<T>(_ from: [T]) -> JSON where T: InternalJsonConvertible {
		var jsonArray = [JSON]()
		jsonArray.reserveCapacity(from.count)
		for item in from {
			jsonArray.append(item.internalJson)
		}
        return JSON(jsonArray)
	}
	
	func customArrayValue<T>() -> [T] where T: InternalJsonConvertible {
		let jsonArray: [JSON] = arrayValue
		var result = [T]()
		result.reserveCapacity(jsonArray.count)
		for jsonItem in jsonArray {
			result.append(T(internalJson: jsonItem))
		}
		return result
	}
	
    func twoDArrayValue<T>() -> [[T]] where T: InternalJsonConvertible {
		let json = arrayValue
		var result = [[T]]()
		result.reserveCapacity(json.count)
		for rowJson in json {
			var row = [T]()
			row.reserveCapacity(rowJson.count)
			for columnJson in rowJson.arrayValue {
                let value = T(internalJson: columnJson)
				row.append(value)
			}
			result.append(row)
		}
		return result
	}
}
