//
// HTTPUtils.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
    public class func formUrlencode(dictionary: [String: Any?]) -> String {
        var result = ""
        for (key, valueOrNil) in dictionary {
            guard let value = valueOrNil else {
                // Ignore keys with nil values
                continue
            }
            let keyString = String(key)
            let valueString = String(value)
            
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
    public class func formUrlencode(dictionary: [String: String]) -> String {
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
