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
    enum Format {
        case Word
        case Int
        case Double
    }
    
    enum Mode {
        case SingleWord
        case ZeroOrMore
        case OneOrMore
    }
    
    var format = Format.Word
    var mode = Mode.SingleWord
    let whitespaceAndNewline = NSCharacterSet.whitespaceAndNewlineCharacterSet()

    init(_ parameterName: String? = nil, _ format: Format = .Word, capture: Bool = true) {
        self.parameterName = parameterName
        self.format = format
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(scanner: NSScanner) -> Any? {
        switch mode {
        case .SingleWord:
            return fetchNextElement(scanner)
        case .ZeroOrMore, .OneOrMore:
            var elements = [Any]()
            while let element = fetchNextElement(scanner) {
                elements.append(element)
            }
            if mode == .OneOrMore && elements.isEmpty {
                return nil
            }
            return elements
        }
    }
    
    func fetchNextElement(scanner: NSScanner) -> Any? {
        switch format {
        case .Word: return scanner.scanUpToCharactersFromSet(whitespaceAndNewline)
        case .Int: return scanner.scanInt()
        case .Double: return scanner.scanDouble()
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
