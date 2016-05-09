//
// RestOfString.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class RestOfString: Parameter {
    
    public init(_ parameterName: String? = nil, capture: Bool = true) {
        self.parameterName = parameterName
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(_ scanner: NSScanner) -> Any? {
        guard let restOfString = scanner.scanUpToString("") else {
            return nil
        }
        return restOfString
    }
}
