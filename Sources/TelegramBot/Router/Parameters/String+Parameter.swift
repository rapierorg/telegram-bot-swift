// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension String: Parameter {
    public var shouldCaptureValue: Bool { return false }
    
    public var parameterName: String? { return nil }
    
    public func fetchFrom(_ scanner: NSScanner) -> Any? {
        let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
        return hasPrefix(word) ? word : nil
    }
}
