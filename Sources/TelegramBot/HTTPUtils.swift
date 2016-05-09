//
// HTTPUtils.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class HTTPUtils {
    /// Encodes keys and values in a dictionary for using with
    /// `application/x-www-form-urlencoded` Content-Type and
    /// joins them into a single string.
    ///
    /// Keys corresponding to nil values are skipped and
    /// are not added to the resulting string.
    ///
    /// - SeeAlso: Encoding is performed using String's `formUrlencode` method.
    /// - Returns: Encoded string.
    public class func formUrlencode(_ dictionary: [String: Any?]) -> String {
        var result = ""
        for (key, valueOrNil) in dictionary {
            guard let value = valueOrNil else {
                // Ignore keys with nil values
                continue
            }
            
            let keyString = String(key)
            
            var valueString: String
            
            if let boolValue = value as? Bool {
                if !boolValue {
                    continue
                }
                // If true, add "key=" to encoded string
                valueString = "true"
            } else {
                valueString = String(value)
            }
            
            if !result.isEmpty {
                result += "&"
            }
            let keyUrlencoded = keyString.formUrlencode()
            let valueUrlencoded = valueString.formUrlencode()
            result += "\(keyUrlencoded)=\(valueUrlencoded)"
        }
        return result
    }
    
    /// Encodes keys and values in a dictionary for using with
    /// `application/x-www-form-urlencoded` Content-Type and
    /// joins them into a single string.
    ///
    /// - SeeAlso: Encoding is performed using String's `formUrlencode` method.
    /// - Returns: Encoded string.
    public class func formUrlencode(_ dictionary: [String: String]) -> String {
        var result = ""
        for (keyString, valueString) in dictionary {
            if !result.isEmpty {
                result += "&"
            }
            let keyUrlencoded = keyString.formUrlencode()
            let valueUrlencoded = valueString.formUrlencode()
            result += "\(keyUrlencoded)=\(valueUrlencoded)"
        }
        return result
    }
}
