//
// Command.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class Command: Parameter {
    public enum SlashMode {
        /// Both 'command' and '/command' allowed
        case Optional
        /// Only '/command' allowed
        case Required
    }
    
    let name: String
    let nameWithSlash: String
    let slash: SlashMode
    
    public init(_ name: String, slash: SlashMode = .Optional) {
        self.slash = slash
        if name.hasPrefix("/") {
            self.nameWithSlash = name
			self.name = name.substring(from: name.startIndex.successor())
            print("WARNING: Command() parameter shouldn't start with '/', the slash is added automatically if needed")
        } else {
            self.nameWithSlash = "/" + name
            self.name = name
        }
    }
    
    public let shouldCaptureValue = false
    public var parameterName: String? = nil
    
    public func fetchFrom(_ scanner: NSScanner) -> Any? {
        let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()
        guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
            return nil
        }
		let matchAnyCommand = name.isEmpty
        switch slash {
        case .Required:
			if matchAnyCommand && word.hasPrefix("/") {
				return word
			}
            if nameWithSlash.hasPrefix(word) {
                return word
            }
        case .Optional:
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
