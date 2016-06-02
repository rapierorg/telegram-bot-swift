// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

extension SwiftyJSON.JSON {
    /// - Returns: True if json is empty or of unknown type
    public var isNullOrUnknown: Bool {
        return type == .Null || type == .Unknown
    }
	
	/// Print with indentation.
	public func prettyPrint() {
		print(debugDescription)
	}
	
	init<T where T: JsonObject>(_ from: [T]) {
		var jsonArray = [JSON]()
		jsonArray.reserveCapacity(from.count)
		for item in from {
			jsonArray.append(item.json)
		}
		self = JSON(jsonArray)
	}
	
	func arrayValue<T where T: JsonObject>() -> [T] {
		let jsonArray: [JSON] = arrayValue
		var result = [T]()
		result.reserveCapacity(jsonArray.count)
		for jsonItem in jsonArray {
			result.append(T(json: jsonItem))
		}
		return result
	}
	
	func twoDArrayValue<T>() -> [[T]] {
		let json = arrayValue
		var result = [[T]]()
		result.reserveCapacity(json.count)
		for rowJson in json {
			var row = [T]()
			row.reserveCapacity(rowJson.count)
			for columnJson in rowJson.arrayValue {
				guard let value = columnJson.rawValue as? T else {
					continue
				}
				row.append(value)
			}
			result.append(row)
		}
		return result
	}
}
