// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

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
    //case ResponseParseError(json: JSON,
    //    data: NSData, response: NSHTTPURLResponse)
    
    /// Server error (server returned "ok: false")
    case ServerError(telegramResponse: Response,
        data: NSData, response: NSHTTPURLResponse)
    
    /// No `result` in Telegram response
    //case NoResult(telegramResponse: Response,
    //    data: NSData, response: NSHTTPURLResponse)
    
    /// `Result` couldn't be parsed
    //case ResultParseError(json: JSON)
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
        //case .ResponseParseError(_, _, _):
        //    return "Error while parsing response"
        case .ServerError(_, _, _):
            return "Telegram server returned an error"
        //case .NoResult(_, _, _):
        //    return "No result in Telegram response"
        //case .ResultParseError:
        //    return "Result couldn't be parsed"
        }
    }
}
