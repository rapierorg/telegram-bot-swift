//
// DataTaskError.swift
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

/// Telegram DataTask errors
public enum DataTaskError {
    /// NSDataTask returned an error
    case GenericError(
        data: NSData?, response: NSURLResponse?, error: NSError)
    
    /// Response is not NSHTTPURLResponse
    case InvalidResponseType(
        data: NSData?, response: NSURLResponse?)
    
    /// Status Code is not 200 (OK)
    case InvalidStatusCode(statusCode: Int,
        data: NSData?, response: NSHTTPURLResponse)
    
    /// Telegram server returned no data
    case NoDataReceived(response: NSHTTPURLResponse)
    
    /// Response couldn't be parsed
    case ResponseParseError(json: JSON,
        data: NSData, response: NSHTTPURLResponse)
    
    /// Server error (server returned "ok: false")
    case ServerError(telegramResponse: Response,
        data: NSData, response: NSHTTPURLResponse)
    
    /// No `result` in Telegram response
    case NoResult(telegramResponse: Response,
        data: NSData, response: NSHTTPURLResponse)
    
    /// `Result` couldn't be parsed
    case ResultParseError(json: JSON)
}

extension DataTaskError: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        switch self {
        case .GenericError(_, _, let error):
            return "dataTaskWithRequest: error: \(error.localizedDescription)"
        case .InvalidResponseType(_, _):
            return "Response is not NSHTTPURLResponse"
        case .InvalidStatusCode(let statusCode, _, _):
            return "Expected status code 200, got \(statusCode)"
        case .NoDataReceived(_):
            return "No data received"
        case .ResponseParseError(_, _, _):
            return "Error while parsing response"
        case .ServerError(_, _, _):
            "Telegram server returned an error"
        case .NoResult(_, _, _):
            return "No result in Telegram response"
        case .ResultParseError:
            return "Result couldn't be parsed"
        }
        return "Unknown error"
    }
}
