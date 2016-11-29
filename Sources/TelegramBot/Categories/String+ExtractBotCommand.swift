// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import ScannerUtils

extension String {
	/// - Parameter botName: bot name to remove.
    /// - Returns: "/command@botName arguments" -> "/command arguments". Nil if bot name does not match `botName` parameter.
    public func without(botName: BotName) -> String? {
        let scanner = Scanner(string: self)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = nil
        
        let whitespaceAndNewline = CharacterSet.whitespacesAndNewlines
        scanner.skipCharacters(from: whitespaceAndNewline)
        
        guard scanner.skipString("/") else {
            return self
        }
        
        let alphanumericCharacters = CharacterSet.alphanumerics
        guard scanner.skipCharacters(from: alphanumericCharacters) else {
            return self
        }

        let usernameSeparatorIndex = scanner.scanLocation

        let usernameSeparator = "@"
        guard scanner.skipString(usernameSeparator) else {
            return self
        }

        // A set of characters allowed in bot names
        let usernameCharacters = CharacterSet(charactersIn:
            "abcdefghijklmnopqrstuvwxyz" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "1234567890_")
        guard let username = scanner.scanCharacters(from: usernameCharacters) else {
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
