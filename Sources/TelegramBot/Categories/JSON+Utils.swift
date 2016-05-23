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
}
