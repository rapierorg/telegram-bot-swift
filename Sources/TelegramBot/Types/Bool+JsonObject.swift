// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.


import Foundation
import SwiftyJSON

extension Bool: JsonObject {
	public init(json: JSON) {
		self = json.boolValue
	}
	
	public var json: JSON {
		get {
			return JSON(self)
		}
		set {
			self = newValue.boolValue
		}
	}
}
