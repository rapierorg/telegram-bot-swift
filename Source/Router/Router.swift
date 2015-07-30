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
    public var allowPartialMatch: Bool = false
    
    public func addPath(path: Path) {
        paths.append(path)
    }
    
    public func addPath(parameters: [Parameter], _ handler: Path.Handler) {
        let path = Path(parameters: parameters, handler: handler)
        paths.append(path)
    }
    
    public func processString(string: String) -> Bool {
        let scanner = NSScanner(string: string)
        
        for path in paths {
            if let arguments = fetchArgumentsInPath(path, withScanner: scanner) {
                if path.handler(arguments) {
                    return true
                }
            }
        }
        return false
    }
    
    func fetchArgumentsInPath(path: Path, withScanner scanner: NSScanner) -> Arguments? {
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
        
        if !allowPartialMatch {
            return scanner.atEnd ? arguments : nil
        }
        
        return arguments
    }
    
    var paths = [Path]()
}
