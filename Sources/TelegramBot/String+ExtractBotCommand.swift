//
// String+ExtractBotCommand.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension String {
    /// "/command@botname arguments" -> "/command arguments"
    public func extractBotCommand(_ botName: BotName) -> String? {
        let scanner = NSScanner(string: self)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = nil
        
        let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
        scanner.skipCharactersFromSet(whitespaceAndNewline)
        
        guard scanner.skipString("/") else {
            return self
        }
        
        let alphanumericCharacters = NSCharacterSet.alphanumerics()
        guard scanner.skipCharactersFromSet(alphanumericCharacters) else {
            return self
        }

        let usernameSeparatorIndex = scanner.scanLocation

        let usernameSeparator = "@"
        guard scanner.skipString(usernameSeparator) else {
            return self
        }

        // A set of characters allowed in bot names
        let usernameCharacters = NSCharacterSet(charactersIn:
            "abcdefghijklmnopqrstuvwxyz" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "1234567890_")
        guard let username = scanner.scanCharactersFromSet(usernameCharacters) else {
            // Empty bot name. Treat as no bot name and process the comamnd.
            return self
        }
        
        guard BotName(username: username) == botName else {
            // Another bot's message, skip it.
            return nil
        }
        
        let t = self as NSString
		return t.substring(to: usernameSeparatorIndex) +
			t.substring(from: scanner.scanLocation)
    }
}
