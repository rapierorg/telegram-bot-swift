//
// Arguments.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

public class Arguments {
	typealias T = Arguments
	
	public let scanner: Scanner
	
	public var isAtEnd: Bool {
		return scanner.isAtEnd
	}

	static let whitespaceAndNewline = CharacterSet.whitespacesAndNewlines
	
	init(scanner: Scanner) {
		self.scanner = scanner
	}
	
	public func scanWord() -> String? {
        var word: NSString?
        return scanner.scanUpToCharacters(from: T.whitespaceAndNewline, into: &word) ? (word as String?) : nil
	}
	
	public func scanWords() -> [String] {
		var words = [String]()
		while let word = scanWord() {
			words.append(word)
		}
		return words
	}
	
	public func scanInteger() -> Int? {
		guard let word = scanWord() else {
			return nil
		}
		let validator = Scanner(string: word)
		validator.charactersToBeSkipped = nil
        var value: Int = 0
		guard validator.scanInt(&value), validator.isAtEnd else {
			return nil
		}
		return value
	}
	
    public func scanInt64() -> Int64? {
        guard let word = scanWord() else {
            return nil
        }
        let validator = Scanner(string: word)
        validator.charactersToBeSkipped = nil
        var value: Int64 = 0
        guard validator.scanInt64(&value), validator.isAtEnd else {
            return nil
        }
        return value
    }
    
	public func scanDouble() -> Double? {
		guard let word = scanWord() else {
			return nil
		}
		let validator = Scanner(string: word)
		validator.charactersToBeSkipped = nil
        var value: Double = 0.0
		guard validator.scanDouble(&value), validator.isAtEnd else {
			return nil
		}
		return value
	}
	
	public func scanRestOfString() -> String {
        var restOfString: NSString?
        guard scanner.scanUpTo("", into: &restOfString) else {
			return ""
		}
		return (restOfString as String?) ?? ""
	}
	
	public func skipRestOfString() {
        scanner.scanLocation = scanner.string.utf16.count
	}
}
