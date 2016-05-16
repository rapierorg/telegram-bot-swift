// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension String {
    public func trim(set: NSCharacterSet = NSCharacterSet.whitespacesAndNewlines()) -> String {
        return trimmingCharacters(in: set)
    }
}
