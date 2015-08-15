//
// Word.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/Word: /*NS*/Parameter {
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
            switch format {
            case .Word: return fetchWord(scanner)
            case .Int: return fetchInt(scanner)
            case .Double: return fetchDouble(scanner)
            }
        case .ZeroOrMore, .OneOrMore:
            switch format {
            case .Word:
                var elements = [String]()
                while let element = fetchWord(scanner) {
                    elements.append(element)
                }
                if mode == .OneOrMore && elements.isEmpty {
                    return nil
                }
                return elements
            case .Int:
                var elements = [Int]()
                while let element = fetchInt(scanner) {
                    elements.append(element)
                }
                if mode == .OneOrMore && elements.isEmpty {
                    return nil
                }
                return elements
            case .Double:
                var elements = [Double]()
                while let element = fetchDouble(scanner) {
                    elements.append(element)
                }
                if mode == .OneOrMore && elements.isEmpty {
                    return nil
                }
                return elements
            }
        }
    }

    func fetchWord(scanner: NSScanner) -> String? {
        return scanner.scanUpToCharactersFromSet(whitespaceAndNewline)
    }
    
    func fetchInt(scanner: NSScanner) -> Int? {
        guard let word = fetchWord(scanner) else {
            return nil
        }
        let validator = NSScanner(string: word)
        validator.charactersToBeSkipped = nil
        guard let value = validator.scanInt() where validator.atEnd else {
            return nil
        }
        return value
    }
    
    func fetchDouble(scanner: NSScanner) -> Double? {
        guard let word = fetchWord(scanner) else {
            return nil
        }
        let validator = NSScanner(string: word)
        validator.charactersToBeSkipped = nil
        guard let value = validator.scanDouble() where validator.atEnd else {
            return nil
        }
        return value
    }
}

postfix operator + { }

postfix func + (word: /*NS*/Word) -> /*NS*/Word {
    word.mode = .OneOrMore
    return word
}

postfix operator * { }

postfix func * (word: /*NS*/Word) -> /*NS*/Word {
    word.mode = .ZeroOrMore
    return word
}
