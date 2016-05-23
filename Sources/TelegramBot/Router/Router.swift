// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Router {
	public typealias PartialMatchHandler = (unmatched: String, path: Path)->()
	public typealias Path = (command: Command, handler: Handler)
    
    public var allowPartialMatch: Bool = true
    public var partialMatchHandler: PartialMatchHandler?
    public var caseSensitive: Bool = false
    public var charactersToBeSkipped: NSCharacterSet? = NSCharacterSet.whitespacesAndNewlines()

	public var fallbackHandler: Handler?

    public init(allowPartialMatch: Bool, partialMatchHandler: PartialMatchHandler? = nil) {
        
        self.allowPartialMatch = allowPartialMatch
        self.partialMatchHandler = partialMatchHandler

        if allowPartialMatch && partialMatchHandler == nil {
            print("WARNING: partialMatchHandler not set. Part of user input will be ignored silently.")
        }
    }

    public convenience init(partialMatchHandler: PartialMatchHandler? = nil) {
        self.init(allowPartialMatch: true, partialMatchHandler: partialMatchHandler)
    }
	
	public func add(_ command: Command, _ handler: Handler) {
		paths.append(Path(command, handler))
	}
	
    public func add(_ command: Command, _ handler: () throws->(Bool)) {
        paths.append(Path(command, .CancellableHandlerWithoutArguments(handler)))
    }

	public func add(_ command: Command, _ handler: () throws->()) {
        paths.append(Path(command, .NonCancellableHandlerWithoutArguments(handler)))
    }

	public func add(_ command: Command, _ handler: (ArgumentScanner) throws->(Bool)) {
        paths.append(Path(command, .CancellableHandlerWithArguments(handler)))
    }

    public func add(_ command: Command, _ handler: (ArgumentScanner) throws->()) {
        paths.append(Path(command, .NonCancellableHandlerWithArguments(handler)))
    }
	
    public func process(_ string: String) throws -> Bool {
        let scanner = NSScanner(string: string)
        scanner.caseSensitive = caseSensitive
        scanner.charactersToBeSkipped = charactersToBeSkipped
		let originalScanLocation = scanner.scanLocation
		
		var lastPath: Path?
		
		// After processing the command, check that no unprocessed text is left
		defer {
			// Note that scanner.atEnd automatically ignores charactersToBeSkipped
			if !scanner.isAtEnd {
				// Partial match
				if !allowPartialMatch {
					if let handler = partialMatchHandler {
						if let unmatched = scanner.scanUpToString("") {
							handler(unmatched: unmatched, path: lastPath!)
						} else {
							print("Inconsistent scanner state: expected data, got empty string")
						}
					}
				}
			}

		}
		
		for path in paths {
			lastPath = path
			guard let command = path.command.fetchFrom(scanner) else {
				scanner.scanLocation = originalScanLocation
				continue
			}
			
			let arguments = ArgumentScanner(scanner: scanner, command: command)
			let handler = path.handler

			if try runHandler(handler, arguments: arguments) {
				return true
			}
			
			
			scanner.scanLocation = originalScanLocation
		}

		if let fallbackHandler = fallbackHandler {
			let arguments = ArgumentScanner(scanner: scanner, command: "")
			return try runHandler(fallbackHandler, arguments: arguments)
		}
		
		return false
    }
	
	func runHandler(_ handler: Handler, arguments: ArgumentScanner) throws -> Bool {
		switch handler {
		case let .CancellableHandlerWithoutArguments(handler):
			if try handler() {
				return true
			}
		case let .NonCancellableHandlerWithoutArguments(handler):
			try handler()
			return true
		case let .CancellableHandlerWithArguments(handler):
			if try handler(arguments) {
				return true
			}
		case let .NonCancellableHandlerWithArguments(handler):
			try handler(arguments)
			return true
		}
		
		return false
	}
	
	var paths = [Path]()
}
