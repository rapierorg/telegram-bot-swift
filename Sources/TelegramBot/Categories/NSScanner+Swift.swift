//
// Scanner+Compatibility.swift
//
// This source file is part of the SMUD open source project
//
// Copyright (c) 2016 SMUD project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of SMUD project authors
//

import Foundation

extension Scanner {
    #if os(Linux) || os(Windows)
    public var isAtEnd: Bool { return atEnd }
    #endif
    
    #if os(OSX)
    public func scanInteger() -> Int? {
        var result: Int = 0
        return scanInt(&result) ? result : nil
    }
    #endif

    #if os(OSX)
    public func scanInt32() -> Int32? {
        var result: Int32 = 0
        return scanInt32(&result) ? result : nil
    }
    #endif

    #if os(OSX)
    public func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanInt64(&result) ? result : nil
    }
    #else
    public func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanLongLong(&result) ? result : nil
    }
    #endif

    public func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }
    
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return scanFloat(&result) ? result : nil
    }

    #if os(OSX)
    public func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt32(&result) ? result : nil
    }
    #else
    public func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt(&result) ? result : nil
    }
    #endif

    #if os(OSX)
    public func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexInt64(&result) ? result : nil
    }
    #else
    public func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexLongLong(&result) ? result : nil
    }
    #endif

    public func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }

    public func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }

    #if os(Linux) || os(Windows)
    public func scanString(_ searchString: String) -> String? {
        return scanString(string: searchString)
    }
    #elseif os(OSX)
    public func scanString(_ searchString: String) -> String? {
        var result: NSString?
        guard scanString(searchString, into: &result) else { return nil }
        return result as? String
    }
    #endif

    #if os(Linux) || os(Windows)
    public func scanCharacters(from set: CharacterSet) -> String? {
        return scanCharactersFromSet(set)
    }
    #elseif os(OSX)
    public func scanCharacters(from: CharacterSet) -> String? {
        var result: NSString?
        guard scanCharacters(from: from, into: &result) else { return nil }
        return result as? String
    }
    #endif

    #if os(Linux) || os(Windows)
    public func scanUpTo(_ string: String) -> String? {
        return scanUpToString(string)
    }
    #elseif os(OSX)
    public func scanUpTo(_ string: String) -> String? {
        var result: NSString?
        guard scanUpTo(string, into: &result) else { return nil }
        return result as? String
    }
    #endif

    #if os(Linux) || os(Windows)
    public func scanUpToCharacters(from set: CharacterSet) -> String? {
        return scanUpToCharactersFromSet(set)
    }
    #elseif os(OSX)
    public func scanUpToCharacters(from set: CharacterSet) -> String? {
        var result: NSString?
        guard scanUpToCharacters(from: set, into: &result) else { return nil }
        return result as? String
    }
    #endif
}

//
// Scanner+Utils.swift
//
// This source file is part of the SMUD open source project
//
// Copyright (c) 2016 SMUD project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of SMUD project authors
//

import Foundation

extension Scanner {
    @discardableResult
    public func skipInteger() -> Bool {
        return scanInteger() != nil
    }
    
    @discardableResult
    public func skipInt32() -> Bool {
        #if os(OSX)
            return scanInt32(nil)
        #else
            return scanInt() != nil
        #endif
    }

    @discardableResult
    public func skipInt64() -> Bool {
        return scanInt64() != nil
    }
    
    @discardableResult
    public func skipUInt64() -> Bool {
        return scanUInt64() != nil
    }
    
    @discardableResult
    public func skipFloat() -> Bool {
        return scanFloat() != nil
    }
    
    public func scanDouble() -> Double? {
        var result: Double = 0.0
        return scanDouble(&result) ? result : nil
    }
    
    @discardableResult
    public func skipDouble() -> Bool {
        return scanDouble() != nil
    }
    
    @discardableResult
    public func skipHexUInt32() -> Bool {
        return scanHexUInt32() != nil
    }
    
    @discardableResult
    public func skipHexUInt64() -> Bool {
        return scanHexUInt64() != nil
    }
    
    @discardableResult
    public func skipHexFloat() -> Bool {
        return scanHexFloat() != nil
    }
    
    @discardableResult
    public func skipHexDouble() -> Bool {
        return scanHexDouble() != nil
    }

    @discardableResult
    public func skipString(_ string: String) -> Bool {
        return scanString(string) != nil
    }

    @discardableResult
    func skipCharacters(from: CharacterSet) -> Bool {
        return scanCharacters(from: from) != nil
    }
    
    @discardableResult
    public func skipUpTo(_ string: String) -> Bool {
        return scanUpTo(string) != nil
    }

    @discardableResult
    public func skipUpToCharacters(from set: CharacterSet) -> Bool {
        return scanUpToCharacters(from: set) != nil
    }

    public var scanLocationInCharacters: Int {
        let utf16 = string.utf16
        guard let to16 = utf16.index(utf16.startIndex, offsetBy: scanLocation, limitedBy: utf16.endIndex),
            let to = String.Index(to16, within: string) else {
                return 0
        }
        return string.distance(from: string.startIndex, to: to)
    }
    
    private var currentCharacterIndex: String.CharacterView.Index? {
        let utf16 = string.utf16
        guard let to16 = utf16.index(utf16.startIndex, offsetBy: scanLocation, limitedBy: utf16.endIndex),
            let to = String.Index(to16, within: string) else {
                return nil
        }
        // to is a String.CharacterView.Index
        return to
    }
    
    public var parsedText: String {
        guard let index = currentCharacterIndex else { return "" }
        return string.substring(to: index)
    }

    public var textToParse: String {
        guard let index = currentCharacterIndex else { return "" }
        return string.substring(from: index)
    }
    
    public var lineBeingParsed: String {
        let targetLine = self.line()
        var currentLine = 1
        var line = ""
        line.reserveCapacity(256)
        for character in string.characters {
            if currentLine > targetLine {
                break
            }
            
            if character == "\n" || character == "\r\n" {
                currentLine += 1
                continue
            }
            
            if currentLine == targetLine {
                line.append(character)
            }
        }
        return line
    }

    // Very slow, do not in use in loops
    public func line() -> Int {
        let lineCount = 1 + parsedText.characters.filter { $0 == "\n" || $0 == "\r\n" }.count
        return lineCount
    }
    
    // Very slow, do not in use in loops
    public func column() -> Int {
        let text = parsedText
        if let range = text.range(of: "\n", options: .backwards) {
            return text.distance(from: range.upperBound, to: text.endIndex) + 1
        }
        return parsedText.characters.count + 1
    }
}

