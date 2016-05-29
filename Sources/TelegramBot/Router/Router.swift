// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Router {
	public typealias Handler = (args: Arguments) throws -> Bool
	public typealias Path = (contentType: ContentType, handler: Handler)
	
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

	public lazy var unsupportedContentType: Handler? = { args in
		self.bot.respondAsync("Unsupported content type.")
		return true
	}

	public init(bot: TelegramBot) {
		self.bot = bot
    }
	
	public func add(_ contentType: ContentType, _ handler: (Arguments) throws -> Bool) {
		paths.append(Path(contentType, handler))
	}
	
	public func add(_ contentType: ContentType, _ handler: (Arguments) throws->()) {
		add(contentType) { (args: Arguments) -> Bool in
			try handler(args)
			return true
		}
	}
	
	public func add(_ contentType: ContentType, _ handler: () throws->(Bool)) {
		add(contentType) {  (_: Arguments) -> Bool in
			return try handler()
		}
	}
	
	public func add(_ contentType: ContentType, _ handler: () throws->()) {
		add(contentType) {  (args: Arguments) -> Bool in
			try handler()
			return true
		}
	}
	
	public func add(_ command: Command, _ handler: (Arguments) throws -> Bool) {
		paths.append(Path(.command(command), handler))
	}

	public func add(_ command: Command, _ handler: (Arguments) throws->()) {
		add(command) { (args: Arguments) -> Bool in
			try handler(args)
			return true
		}
	}

    public func add(_ command: Command, _ handler: () throws->(Bool)) {
		add(command) {  (_: Arguments) -> Bool in
			return try handler()
		}
    }

	public func add(_ command: Command, _ handler: () throws->()) {
		add(command) {  (args: Arguments) -> Bool in
			try handler()
			return true
		}
    }
	
    public func process(message: Message) throws -> Bool {
		let string = message.extractCommand(for: bot) ?? ""
        let scanner = NSScanner(string: string)
        scanner.caseSensitive = caseSensitive
        scanner.charactersToBeSkipped = charactersToBeSkipped
		let originalScanLocation = scanner.scanLocation
		
		for path in paths {
			var command = ""
			if !match(contentType: path.contentType, message: message, commandScanner: scanner, userCommand: &command) {
				scanner.scanLocation = originalScanLocation
				continue;
			}
			
			let args = Arguments(scanner: scanner, command: command)
			let handler = path.handler

			if try handler(args: args) {
				return try checkPartialMatch(args: args)
			}

			scanner.scanLocation = originalScanLocation
		}

		if !string.isEmpty {
			if let unknownCommand = unknownCommand {
				let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
				let command = scanner.scanUpToCharactersFromSet(whitespaceAndNewline)
				let args = Arguments(scanner: scanner, command: command ?? "")
				if try !unknownCommand(args: args) {
					return try checkPartialMatch(args: args)
				}
				return true
			}
		} else {
			if let unsupportedContentType = unsupportedContentType {
				let args = Arguments(scanner: scanner, command: "")
				return try !unsupportedContentType(args: args)
			}
		}
		
		return false
    }
	
	func match(contentType: ContentType, message: Message, commandScanner: NSScanner, userCommand: inout String) -> Bool {
		switch contentType {
		case .command(let command):
			guard let command = command.fetchFrom(commandScanner) else {
				return false // Does not match path command
			}
			userCommand = command
			return true
		case .audio: return message.audio != nil
		case .document: return message.document != nil
		case .photo: return !message.photo.isEmpty
		case .sticker: return message.sticker != nil
		case .video: return message.video != nil
		//case .voice: return message.voice != nil
		case .contact: return message.contact != nil
		case .location: return message.location != nil
		//case .venue: return message.venue != nil
		case .newChatMember: return message.new_chat_member != nil
		case .leftChatMember: return message.left_chat_member != nil
		case .newChatTitle: return message.new_chat_title != nil
		//case .newChatPhoto: return message.new_chat_photo != nil
		//case .deleteChatPhoto: return message.delete_chat_photo != nil
		//case .groupChatCreated: return message.group_chat_created != nil
		//case .supergroupChatCreated: return message.supergroup_chat_created != nil
		//case .channelChatCreated: return message.channel_chat_created != nil
		//case .migrateToChatId: return message.migrate_to_chat_id != nil
		//case .migrateFromChatId: return message.migrate_from_chat_id != nil
		//case .pinnedMessage: return message.pinned_message != nil
		default: break
		}
		return false
	}
	
	// After processing the command, check that no unprocessed text is left
	func checkPartialMatch(args: Arguments) throws -> Bool {

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
