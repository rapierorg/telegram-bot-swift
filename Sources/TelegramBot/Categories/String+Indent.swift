// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension String {
    /// Indents every line with prefix.
    public func indent(prefix: String = "  ") -> String {
        let lines = characters.split { $0 == "\n" }
        
        var result = String()
        result.reserveCapacity(characters.count + lines.count * prefix.characters.count)

        // $1 is String.CharacterView
        //result = lines.reduce(result) { $0 + prefix + String($1) + "\n" }
        // Optimized:
        for line in lines {
            result += prefix
            result += String(line)
            result += "\n"
        }
        
        return result
    }
}
