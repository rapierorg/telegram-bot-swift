// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Router {
	public typealias Handler = (args: ArgumentScanner) throws -> Bool
	public typealias Path = (command: Command, handler: Handler)
    
    public var allowPartialMatch: Bool = true
    public var partialMatchHandler: Handler?
    public var caseSensitive: Bool = false
    public var charactersToBeSkipped: NSCharacterSet? = NSCharacterSet.whitespacesAndNewlines()

	public var fallback: Handler?

    public init(allowPartialMatch: Bool, partialMatchHandler: Handler? = nil) {
        
        self.allowPartialMatch = allowPartialMatch
        self.partialMatchHandler = partialMatchHandler

        if allowPartialMatch && partialMatchHandler == nil {
            print("WARNING: partialMatchHandler not set. Part of user input will be ignored silently.")
        }
    }

    public convenience init(partialMatchHandler: Handler? = nil) {
        self.init(allowPartialMatch: true, partialMatchHandler: partialMatchHandler)
    }
	
	public func add(_ command: Command, _ handler: (ArgumentScanner) throws -> Bool) {
		paths.append(Path(command, handler))
	}

	public func add(_ command: Command, _ handler: (ArgumentScanner) throws->()) {
		add(command) { (args: ArgumentScanner) -> Bool in
			try handler(args)
			return true
		}
	}

    public func add(_ command: Command, _ handler: () throws->(Bool)) {
		add(command) {  (_: ArgumentScanner) -> Bool in
			return try handler()
		}
    }

	public func add(_ command: Command, _ handler: () throws->()) {
		add(command) {  (args: ArgumentScanner) -> Bool in
			try handler()
			return true
		}
    }
	
    public func process(_ string: String) throws -> Bool {
        let scanner = NSScanner(string: string)
        scanner.caseSensitive = caseSensitive
        scanner.charactersToBeSkipped = charactersToBeSkipped
		let originalScanLocation = scanner.scanLocation
		
		for path in paths {
			guard let command = path.command.fetchFrom(scanner) else {
				scanner.scanLocation = originalScanLocation
				continue
			}
			
			let arguments = ArgumentScanner(scanner: scanner, command: command)
			let handler = path.handler

			if try handler(args: arguments) {
				return try checkPartialMatch(args: arguments)
			}
			
			
			scanner.scanLocation = originalScanLocation
		}

		if let fallback = fallback {
			let arguments = ArgumentScanner(scanner: scanner, command: "")
			if try fallback(args: arguments) {
				return try checkPartialMatch(args: arguments)
			}
		}
		
		return false
    }
	
	// After processing the command, check that no unprocessed text is left
	func checkPartialMatch(args: ArgumentScanner) throws -> Bool {

		// Note that scanner.atEnd automatically ignores charactersToBeSkipped
		if !args.isAtEnd {
			// Partial match
			if !allowPartialMatch {
				if let handler = partialMatchHandler {
					return try handler(args: args)
				}
			}
		}
		
		return true
	}
	
	var paths = [Path]()
}
