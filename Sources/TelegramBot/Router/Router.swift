// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Router {
	public typealias Handler = (args: ArgumentScanner) throws -> Bool
	public typealias Path = (command: Command, handler: Handler)
	
    public var caseSensitive: Bool = false
    public var charactersToBeSkipped: NSCharacterSet? = NSCharacterSet.whitespacesAndNewlines()

	public var bot: TelegramBot

	public lazy var partialMatch: Handler? = { args in
		self.bot.respondAsync("❗ Part of your input was ignored: \(args.scanRestOfString())")
		return true
	}
	
	public lazy var unknownCommand: Handler? = { args in
		self.bot.respondAsync("Unrecognized command: \(args.command). Type /help for help.")
		return true
	}

	public init(bot: TelegramBot) {
		self.bot = bot
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
			
			let args = ArgumentScanner(scanner: scanner, command: command)
			let handler = path.handler

			if try handler(args: args) {
				return try checkPartialMatch(args: args)
			}
			
			
			scanner.scanLocation = originalScanLocation
		}

		if let unknownCommand = unknownCommand {
			let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
			let command = scanner.scanUpToCharactersFromSet(whitespaceAndNewline)
			let args = ArgumentScanner(scanner: scanner, command: command ?? "")
			if try unknownCommand(args: args) {
				return try checkPartialMatch(args: args)
			}
		}
		
		return false
    }
	
	// After processing the command, check that no unprocessed text is left
	func checkPartialMatch(args: ArgumentScanner) throws -> Bool {

		// Note that scanner.atEnd automatically ignores charactersToBeSkipped
		if !args.isAtEnd {
			// Partial match
			if let handler = partialMatch {
				return try handler(args: args)
			}
		}
		
		return true
	}
	
	var paths = [Path]()
}
