//
// Response.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Response to Bot API request.
public class /*NS*/Response {
    /// If `ok` equals true, the request was successful and the result of the query can be found in the `result` field. In case of an unsuccessful request, ‘ok’ equals false and the error is explained in the ‘errorDescription’.
    public var ok: Bool
    
    /// *Optional.* Error description.
    public var errorDescription: String?
    
    /// *Optional.* Error code. Its contents are subject to change in the future.
    public var errorCode: Int?
    
    /// *Optional.* Result.
    public var result: JSON?
    
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
    
    public var prettyPrint: String {
        var result = "Response(\n"
            "  ok: \(ok)\n"
        if let errorDescription = errorDescription {
            result += "  errorDescription: \(errorDescription)\n"
        }
        if let errorCode = errorCode {
            result += "  errorCode: \(errorCode)\n"
        }
        if let value = self.result {
            result += "  result: \(value)\n"
        }
        result += ")"
        return result
    }
}

extension /*NS*/Response: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Response(ok: \(ok), errorDescription: \(errorDescription.unwrapAndPrint), " +
            "errorCode: \(errorCode.unwrapAndPrint), result: \(result.unwrapAndPrint))"
    }
}

