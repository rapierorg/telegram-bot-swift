// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

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
