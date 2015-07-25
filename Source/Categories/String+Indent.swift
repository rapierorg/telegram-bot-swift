//
// String+Indent.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension String {
    /// Indents every line with prefix.
    public func indent(prefix: String = "  ") -> String {
        let lines = split(characters) { $0 == "\n" }
        
        var result = String()
        result.reserveCapacity(characters.count + lines.count * prefix.characters.count)

        // $1 is String.CharacterView
        result = lines.reduce(result) { $0 + prefix + String($1) + "\n" }
        
        return result
    }
}