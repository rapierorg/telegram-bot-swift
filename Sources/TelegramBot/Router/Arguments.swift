// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Arguments {
	typealias T = Arguments
	
	public let scanner: NSScanner
	public let command: String

	public var isAtEnd: Bool {
		return scanner.isAtEnd
	}
	
	static let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()

	init(scanner: NSScanner, command: String) {
		self.scanner = scanner
		self.command = command
	}
	
	public func scanWord() -> String? {
		return scanner.scanUpToCharactersFromSet(T.whitespaceAndNewline)
	}
	
	public func scanWords() -> [String] {
		var words = [String]()
		while let word = scanWord() {
			words.append(word)
		}
		return words
	}

	public func scanInt() -> Int? {
		guard let word = scanWord() else {
			return nil
		}
		let validator = NSScanner(string: word)
		validator.charactersToBeSkipped = nil
		guard let value = validator.scanInt() where validator.isAtEnd else {
			return nil
		}
		return value
	}

	public func scanDouble() -> Double? {
		guard let word = scanWord() else {
			return nil
		}
		let validator = NSScanner(string: word)
		validator.charactersToBeSkipped = nil
		guard let value = validator.scanDouble() where validator.isAtEnd else {
			return nil
		}
		return value
	}
	
	public func scanRestOfString() -> String {
		guard let restOfString = scanner.scanUpToString("") else {
			return ""
		}
		return restOfString
	}
	
	public func skipRestOfString() {
		scanner.skipUpToString("")
	}
}
