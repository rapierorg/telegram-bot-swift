// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Command {
    public struct Options: OptionSet {
        public var rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }

        /// Match all words in a command exactly. Do not skip "/" prefix, if present.
        /// Note that comparision is still case insensitive by default.
        public static let exactMatch = Options(rawValue: 1 << 0)

        /// Require commands to be prefixed with "/" even in private chats.
        /// By default prefixing is required only in group chats.
        /// Ignored if `exactMatch` flag is set.
        public static let slashRequired = Options(rawValue: 1 << 1)
        
        /// Case sensitive comparision of commands.
        public static let caseSensitive = Options(rawValue: 1 << 2)
    }
    
    let name: String
    let nameWithSlash: String
    let options: Options
    
    public init(_ name: String, options: Options = []) {
        self.options = options
        if name.hasPrefix("/") {
            self.nameWithSlash = name
			self.name = name.substring(from: name.index(after: name.startIndex))
            print("WARNING: Command name shouldn't start with '/', the slash is added automatically if needed")
        } else {
            self.nameWithSlash = "/" + name
            self.name = name
        }
    }
    	
    public func fetchFrom(_ scanner: Scanner, caseSensitive: Bool = false) -> String? {
        let whitespaceAndNewline = CharacterSet.whitespacesAndNewlines
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
        if options.contains(.exactMatch) {
            if name.isEmpty {
                return word
            }
            let caseSensitive = caseSensitive || options.contains(.caseSensitive)
            if name.hasPrefix(word, caseInsensitive: !caseSensitive) {
                return word
            }
        } else if options.contains(.slashRequired) {
			if name.isEmpty && word.hasPrefix("/") {
				return word
			}
            let caseSensitive = caseSensitive || options.contains(.caseSensitive)
            if nameWithSlash.hasPrefix(word, caseInsensitive: !caseSensitive) {
                return word
            }
        } else {
			if name.isEmpty {
				return word
			}
            let caseSensitive = caseSensitive || options.contains(.caseSensitive)
            if name.hasPrefix(word, caseInsensitive: !caseSensitive) || nameWithSlash.hasPrefix(word, caseInsensitive: !caseSensitive) {
                return word
            }
        }
        return nil
    }
}
