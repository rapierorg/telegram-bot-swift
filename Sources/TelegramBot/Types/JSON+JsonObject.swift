// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.


import Foundation
import SwiftyJSON

extension JSON: JsonConvertible {
	public init(json: JSON) {
		self = json
	}
	
	public var json: JSON {
		get {
			return self
		}
		set {
			self = newValue
		}
	}
}
