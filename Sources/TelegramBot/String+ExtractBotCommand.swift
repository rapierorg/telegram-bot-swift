// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension String {
	/// - Parameter botName: bot name to remove.
    /// - Returns: "/command@botName arguments" -> "/command arguments". Nil if bot name does not match `botName` parameter.
    public func removeBotName(_ botName: BotName) -> String? {
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
