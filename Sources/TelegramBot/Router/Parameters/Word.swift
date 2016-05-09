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
    public enum Format {
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
    let whitespaceAndNewline = NSCharacterSet.whitespacesAndNewlines()

    public init(_ parameterName: String? = nil, _ format: Format = .Word, capture: Bool = true) {
        self.parameterName = parameterName
        self.format = format
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(_ scanner: NSScanner) -> Any? {
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

    func fetchWord(_ scanner: NSScanner) -> String? {
        return scanner.scanUpToCharactersFromSet(whitespaceAndNewline)
    }
    
    func fetchInt(_ scanner: NSScanner) -> Int? {
        guard let word = fetchWord(scanner) else {
            return nil
        }
        let validator = NSScanner(string: word)
        validator.charactersToBeSkipped = nil
        guard let value = validator.scanInt() where validator.isAtEnd else {
            return nil
        }
        return value
    }
    
    func fetchDouble(_ scanner: NSScanner) -> Double? {
        guard let word = fetchWord(scanner) else {
            return nil
        }
        let validator = NSScanner(string: word)
        validator.charactersToBeSkipped = nil
        guard let value = validator.scanDouble() where validator.isAtEnd else {
            return nil
        }
        return value
    }
}

postfix operator + { }

public postfix func + (word: Word) -> Word {
    word.mode = .OneOrMore
    return word
}

postfix operator * { }

public postfix func * (word: Word) -> Word {
    word.mode = .ZeroOrMore
    return word
}
