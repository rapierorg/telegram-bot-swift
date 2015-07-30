//
// Word.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class Word: Parameter {
    
    init(_ parameterName: String? = nil, capture: Bool = true) {
        self.parameterName = parameterName
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(scanner: NSScanner) -> Any? {
        let whitespaceAndNewline = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
        print("Word:Parameter: self=\(self), word=\(word)")
        return word
    }
}
