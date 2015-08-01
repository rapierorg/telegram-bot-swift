//
// Command.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class Command: Parameter {
    let name: String
    let nameWithSlash: String
    
    init(_ name: String) {
        if name.hasPrefix("/") {
            self.nameWithSlash = name
            self.name = name.substringFromIndex(name.startIndex.successor())
            print("WARNING: Command() parameter shouldn't start with '/', the slash is added automatically if needed")
        } else {
            self.nameWithSlash = "/" + name
            self.name = name
        }
    }
    
    public let shouldCaptureValue = false
    public var parameterName: String? = nil
    
    public func fetchFrom(scanner: NSScanner) -> Any? {
        let whitespaceAndNewline = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
        if name.hasPrefix(word) || nameWithSlash.hasPrefix(word) {
            return word
        }
        return nil
    }
}
