//
// Response.swift
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
import SwiftyJSON

/// Response to Bot API request.
public class Response {
    /// If `ok` equals true, the request was successful and the result of the query can be found in the `result` field. In case of an unsuccessful request, ‘ok’ equals false and the error is explained in the ‘errorDescription’.
    var ok: Bool
    
    /// *Optional.* Error description.
    var errorDescription: String?
    
    /// *Optional.* Error code. Its contents are subject to change in the future.
    var errorCode: Int?
    
    /// *Optional.* Result.
    var result: JSON?
    
    /// Create an empty instance.
    public init() {
        ok = false
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let ok = json["ok"].bool else { return nil }
        self.ok = ok
        
        if ok {
            result = json["result"]
        } else {
            errorDescription = json["description"].string
            errorCode = json["error_code"].int
        }
    }
}

extension Response: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Response(ok: \(ok), errorDescription: \(errorDescription.prettyPrint), " +
            "errorCode: \(errorCode.prettyPrint), result: \(result.prettyPrint))"
    }
}

