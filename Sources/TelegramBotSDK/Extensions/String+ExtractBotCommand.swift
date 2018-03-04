//
// String+ExtractBotCommand.swift
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

extension String {
	/// - Parameter botName: bot name to remove.
    /// - Returns: "/command@botName arguments" -> "/command arguments". Nil if bot name does not match `botName` parameter.
    public func without(botName: BotName) -> String? {
        let scanner = Scanner(string: self)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = nil
        
        let whitespaceAndNewline = CharacterSet.whitespacesAndNewlines
        scanner.scanCharacters(from: whitespaceAndNewline, into: nil)
        
        guard scanner.scanString("/", into: nil) else {
            return self
        }
        
        let alphanumericCharacters = CharacterSet.alphanumerics
        guard scanner.scanCharacters(from: alphanumericCharacters, into: nil) else {
            return self
        }

        let usernameSeparatorIndex = scanner.scanLocation

        let usernameSeparator = "@"
        guard scanner.scanString(usernameSeparator, into: nil) else {
            return self
        }

        // A set of characters allowed in bot names
        let usernameCharacters = CharacterSet(charactersIn:
            "abcdefghijklmnopqrstuvwxyz" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "1234567890_")
        var usernameNS: NSString?
        guard scanner.scanCharacters(from: usernameCharacters, into: &usernameNS),
                let username = usernameNS as String? else {
            // Empty bot name. Treat as no bot name and process the comamnd.
            return self
        }
        
        guard BotName(username: username) == botName else {
            // Another bot's message, skip it.
            return nil
        }
        
        let t = NSString(string: self)
		return t.substring(to: usernameSeparatorIndex) +
			t.substring(from: scanner.scanLocation)
    }
}
