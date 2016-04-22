//
// Arguments.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/Arguments {
    func append(_ argument: Any, named name: String?) {
        ordered.append(argument)
        if let name = name {
            byName[name] = argument
        }
    }
    
    public func array() -> [Any] {
        return ordered
    }
    
    public subscript(name: String) -> /*NS*/Argument {
        return /*NS*/Argument(value: byName[name])
    }
    
    public subscript(index: Int) -> /*NS*/Argument {
        return /*NS*/Argument(value: ordered[index])
    }
    
    var first: Any? { return ordered.first }
    var last: Any? { return ordered.last }
    var isEmpty: Bool { return ordered.isEmpty }
    var count: Int { return ordered.count }
    
    var ordered = [Any]()
    var byName = [String: Any]()
}

extension /*NS*/Arguments: CustomDebugStringConvertible {
    public var debugDescription: String {
        var orderedString = ""
        for argument in ordered {
            if orderedString.isEmpty {
                orderedString = "\(argument)"
            } else {
                orderedString += ", \(argument)"
            }
        }
        
        var byNameString = ""
        for argument in byName {
            if byNameString.isEmpty {
                byNameString = "\(argument.0):\(argument.1)"
            } else {
                byNameString += ", \(argument.0):\(argument.1)"
            }
        }
        
        return "Arguments(ordered: [\(orderedString)], named: [\(byNameString)])"
    }
}
