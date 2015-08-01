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
    public func extractBotCommand(botName: BotName) -> String? {
        let scanner = NSScanner(string: self)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = nil
        
        let whitespaceAndNewline = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        
        scanner.skipCharactersFromSet(whitespaceAndNewline)
        
        // "/command@botname arguments"
        let usernameSeparator = "@"
        
        guard scanner.skipUpToString(usernameSeparator) && !scanner.atEnd else {
            // No bot name specified, process the command.
            return self
        }
        
        let usernameSeparatorIndex = scanner.scanLocation
        
        scanner.skipString(usernameSeparator)
        
        guard let username = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            // Empty bot name. Treat as no bot name and process the comamnd.
            return self
        }
        
        guard BotName(username: username) == botName else {
            // Another bot's message, skip it.
            return nil
        }
        
        let t = self as NSString
        return t.substringToIndex(usernameSeparatorIndex) +
            t.substringFromIndex(scanner.scanLocation)
    }
}