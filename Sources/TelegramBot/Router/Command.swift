// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Command {
    public enum SlashMode {
        /// Both 'command' and '/command' allowed
        case optional
		
        /// Only '/command' allowed
        case required
    }
    
    let name: String
    let nameWithSlash: String
    let slash: SlashMode
    
    public init(_ name: String, slash: SlashMode = .optional) {
        self.slash = slash
        if name.hasPrefix("/") {
            self.nameWithSlash = name
			self.name = name.substring(from: name.index(after: name.startIndex))
            print("WARNING: Command name shouldn't start with '/', the slash is added automatically if needed")
        } else {
            self.nameWithSlash = "/" + name
            self.name = name
        }
    }
    	
    public func fetchFrom(_ scanner: NSScanner) -> String? {
        let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
		let matchAnyCommand = name.isEmpty
        switch slash {
        case .required:
			if matchAnyCommand && word.hasPrefix("/") {
				return word
			}
            if nameWithSlash.hasPrefix(word) {
                return word
            }
        case .optional:
			if matchAnyCommand {
				return word
			}
            if name.hasPrefix(word) || nameWithSlash.hasPrefix(word) {
                return word
            }
        }
        return nil
    }
}
