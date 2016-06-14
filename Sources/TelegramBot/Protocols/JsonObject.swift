// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

public protocol JsonObject: CustomStringConvertible, CustomDebugStringConvertible {
	init(json: JSON)
	var json: JSON { get set }
	func prettyPrint()
}

extension JsonObject {
	public var description: String {
		return json.rawString(encoding: String.Encoding.utf8, options: []) ?? ""
	}
	
	public var debugDescription: String {
		return json.debugDescription
	}
	
	public func prettyPrint() {
		json.prettyPrint()
	}
}
