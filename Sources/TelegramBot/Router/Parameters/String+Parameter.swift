//
// String+Parameter.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension String: /*NS*/Parameter {
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
