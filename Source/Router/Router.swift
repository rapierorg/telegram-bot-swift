//
// Router.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/Router {
    public typealias PartialMatchHandler = (unmatched: String, arguments: /*NS*/Arguments, path: /*NS*/Path)->()
    
    public var allowPartialMatch: Bool = true
    public var partialMatchHandler: PartialMatchHandler?
    public var caseSensitive: Bool = false
    public var charactersToBeSkipped: NSCharacterSet? = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    
    public var defaultHandler: (()->())? = nil

    init(allowPartialMatch: Bool, partialMatchHandler: PartialMatchHandler? = nil) {
        
        self.allowPartialMatch = allowPartialMatch
        self.partialMatchHandler = partialMatchHandler

        if allowPartialMatch && partialMatchHandler == nil {
            print("WARNING: partialMatchHandler not set. Part of user input will be ignored silently.")
        }
    }

    convenience init(partialMatchHandler: PartialMatchHandler? = nil) {
        self.init(allowPartialMatch: true, partialMatchHandler: partialMatchHandler)
    }
    
    public func addPath(path: /*NS*/Path) {
        paths.append(path)
    }
    
    public func addPath(parameters: [/*NS*/Parameter], _ handler: /*NS*/Path.Handler) {
        let path = /*NS*/Path(parameters: parameters, handler: handler)
        paths.append(path)
    }

    public func addPath(parameters: [/*NS*/Parameter], _ handler: ()->(Bool)) {
        let path = /*NS*/Path(parameters: parameters,
            handler: .CancellableHandlerWithoutArguments(handler))
        paths.append(path)
    }

    public func addPath(parameters: [/*NS*/Parameter], _ handler: ()->()) {
        let path = /*NS*/Path(parameters: parameters,
            handler: .NonCancellableHandlerWithoutArguments(handler))
        paths.append(path)
    }

    public func addPath(parameters: [/*NS*/Parameter], _ handler: (/*NS*/Arguments)->(Bool)) {
        let path = /*NS*/Path(parameters: parameters,
            handler: .CancellableHandlerWithArguments(handler))
        paths.append(path)
    }

    public func addPath(parameters: [/*NS*/Parameter], _ handler: (/*NS*/Arguments)->()) {
        let path = /*NS*/Path(parameters: parameters,
            handler: .NonCancellableHandlerWithArguments(handler))
        paths.append(path)
    }

    public func processString(string: String) -> Bool {
        let scanner = NSScanner(string: string)
        scanner.caseSensitive = caseSensitive
        scanner.charactersToBeSkipped = charactersToBeSkipped
        
        for path in paths {
            if let arguments = fetchArgumentsInPath(path, withScanner: scanner) {
                switch path.handler {
                case let .CancellableHandlerWithoutArguments(handler):
                    if handler() {
                        return true
                    }
                case let .NonCancellableHandlerWithoutArguments(handler):
                    handler()
                    return true
                case let .CancellableHandlerWithArguments(handler):
                    if handler(arguments) {
                        return true
                    }
                case let .NonCancellableHandlerWithArguments(handler):
                    handler(arguments)
                    return true
                }
            }
        }
        return false
    }
    
    func fetchArgumentsInPath(path: /*NS*/Path, withScanner scanner: NSScanner) -> /*NS*/Arguments? {
        let originalScanLocation = scanner.scanLocation
        defer {
            scanner.scanLocation = originalScanLocation
        }
        
        let arguments = /*NS*/Arguments()
        
        for parameter in path.parameters {
            guard let argument = parameter.fetchFrom(scanner) else {
                return nil
            }
            if parameter.shouldCaptureValue {
                arguments.append(argument, named: parameter.parameterName)
            }
        }
        
        // Note that scanner.atEnd automatically
        // ignores charactersToBeSkipped
        if !scanner.atEnd {
            // Partial match
            guard allowPartialMatch else {
                return nil
            }
            if let handler = partialMatchHandler {
                guard let unmatched = scanner.scanUpToString("") else {
                    print("Inconsistent scanner state: expected data, got empty string")
                    return nil
                }
                handler(unmatched: unmatched, arguments: arguments, path: path)
            }
        }
        
        return arguments
    }
    
    var paths = [/*NS*/Path]()
}
