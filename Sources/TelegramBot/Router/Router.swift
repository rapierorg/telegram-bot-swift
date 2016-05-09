//
// Router.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class Router {
    public typealias PartialMatchHandler = (unmatched: String, arguments: Arguments, path: Path)->()
    
    public var allowPartialMatch: Bool = true
    public var partialMatchHandler: PartialMatchHandler?
    public var caseSensitive: Bool = false
    public var charactersToBeSkipped: NSCharacterSet? = NSCharacterSet.whitespacesAndNewlines()
    
    public var defaultHandler: (()->())? = nil

    public init(allowPartialMatch: Bool, partialMatchHandler: PartialMatchHandler? = nil) {
        
        self.allowPartialMatch = allowPartialMatch
        self.partialMatchHandler = partialMatchHandler

        if allowPartialMatch && partialMatchHandler == nil {
            print("WARNING: partialMatchHandler not set. Part of user input will be ignored silently.")
        }
    }

    public convenience init(partialMatchHandler: PartialMatchHandler? = nil) {
        self.init(allowPartialMatch: true, partialMatchHandler: partialMatchHandler)
    }
    
    public func addPath(_ path: Path) {
        paths.append(path)
    }
    
    public func addPath(_ parameters: [Parameter], _ handler: Path.Handler) {
        let path = Path(parameters: parameters, handler: handler)
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: ()->(Bool)) {
        let path = Path(parameters: parameters,
            handler: .CancellableHandlerWithoutArguments(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: () throws->(Bool)) {
        let path = Path(parameters: parameters,
            handler: .CancellableHandlerWithoutArgumentsThrows(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: ()->()) {
        let path = Path(parameters: parameters,
            handler: .NonCancellableHandlerWithoutArguments(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: () throws->()) {
        let path = Path(parameters: parameters,
            handler: .NonCancellableHandlerWithoutArgumentsThrows(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: (Arguments)->(Bool)) {
        let path = Path(parameters: parameters,
            handler: .CancellableHandlerWithArguments(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: (Arguments) throws->(Bool)) {
        let path = Path(parameters: parameters,
            handler: .CancellableHandlerWithArgumentsThrows(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: (Arguments)->()) {
        let path = Path(parameters: parameters,
            handler: .NonCancellableHandlerWithArguments(handler))
        paths.append(path)
    }

    public func addPath(_ parameters: [Parameter], _ handler: (Arguments) throws->()) {
        let path = Path(parameters: parameters,
            handler: .NonCancellableHandlerWithArgumentsThrows(handler))
        paths.append(path)
    }

    public func processString(_ string: String) throws -> Bool {
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
                case let .CancellableHandlerWithoutArgumentsThrows(handler):
                    if try handler() {
                        return true
                    }
                case let .NonCancellableHandlerWithoutArguments(handler):
                    handler()
                    return true
                case let .NonCancellableHandlerWithoutArgumentsThrows(handler):
                    try handler()
                    return true
                case let .CancellableHandlerWithArguments(handler):
                    if handler(arguments) {
                        return true
                    }
                case let .CancellableHandlerWithArgumentsThrows(handler):
                    if try handler(arguments) {
                        return true
                    }
                case let .NonCancellableHandlerWithArguments(handler):
                    handler(arguments)
                    return true
                case let .NonCancellableHandlerWithArgumentsThrows(handler):
                    try handler(arguments)
                    return true
                }
            }
        }
        return false
    }
    
    func fetchArgumentsInPath(_ path: Path, withScanner scanner: NSScanner) -> Arguments? {
        let originalScanLocation = scanner.scanLocation
        defer {
            scanner.scanLocation = originalScanLocation
        }
        
        let arguments = Arguments()
        
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
        if !scanner.isAtEnd {
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
    
    var paths = [Path]()
}
