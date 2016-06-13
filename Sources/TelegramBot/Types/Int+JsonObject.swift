// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

extension Int: JsonObject {
	public init(json: JSON) {
		self = json.intValue
	}
	
	public var json: JSON {
		get {
			return JSON(self)
		}
		set {
			self = newValue.intValue
		}
	}
}
