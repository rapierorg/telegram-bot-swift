//
// String+Indent.swift
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
