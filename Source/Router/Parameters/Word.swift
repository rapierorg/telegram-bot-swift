//
// Word.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class Word: Parameter {
    enum Mode {
        case SingleWord
        case ZeroOrMore
        case OneOrMore
    }
    
    var mode = Mode.SingleWord
    
    init(_ parameterName: String? = nil, capture: Bool = true) {
        self.parameterName = parameterName
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(scanner: NSScanner) -> Any? {
        let whitespaceAndNewline = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        switch mode {
        case .SingleWord:
            guard let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) else {
                return nil
            }
            return word
        case .ZeroOrMore, .OneOrMore:
            var words = [String]()
            while let word = scanner.scanUpToCharactersFromSet(whitespaceAndNewline) {
                words.append(word)
            }
            if mode == .OneOrMore && words.isEmpty {
                return nil
            }
            return words
        }
    }
}

postfix operator + { }

postfix func + (word: Word) -> Word {
    word.mode = .OneOrMore
    return word
}

postfix operator * { }

postfix func * (word: Word) -> Word {
    word.mode = .ZeroOrMore
    return word
}
