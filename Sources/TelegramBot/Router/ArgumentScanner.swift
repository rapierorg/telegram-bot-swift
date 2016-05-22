// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class ArgumentScanner {
	typealias T = ArgumentScanner
	
	public let scanner: NSScanner
	public let command: String
	
	static let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()

	init(scanner: NSScanner, command: String) {
		self.scanner = scanner
		self.command = command
	}
	
	func scanWord() -> String? {
		return scanner.scanUpToCharactersFromSet(T.whitespaceAndNewline)
	}

	func scanInt() -> Int? {
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

	func scanDouble() -> Double? {
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
	
	func scanRestOfString() -> String {
		guard let restOfString = scanner.scanUpToString("") else {
			return ""
		}
		return restOfString
	}
}
