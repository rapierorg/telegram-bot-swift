// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Telegram DataTask errors
public enum DataTaskError {
    /// NSDataTask returned an error
    case genericError(
        data: Data?, response: URLResponse?, error: NSError)
    
    /// Response is not NSHTTPURLResponse
    case invalidResponseType(
        data: Data?, response: URLResponse?)
    
    /// Status Code is not 200 (OK)
    case invalidStatusCode(statusCode: Int,
        data: Data?, response: HTTPURLResponse)
    
    /// Telegram server returned no data
    case noDataReceived(response: HTTPURLResponse)
    
    /// Response couldn't be parsed
    //case responseParseError(json: JSON,
    //    data: NSData, response: NSHTTPURLResponse)
    
    /// Server error (server returned "ok: false")
    case serverError(telegramResponse: Response,
        data: Data, response: HTTPURLResponse)
    
    /// No `result` in Telegram response
    //case noResult(telegramResponse: Response,
    //    data: NSData, response: NSHTTPURLResponse)
    
    /// `Result` couldn't be parsed
    //case resultParseError(json: JSON)
}

extension DataTaskError: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        switch self {
        case .genericError(_, _, let error):
            return "dataTaskWithRequest: error: \(error.localizedDescription)"
        case .invalidResponseType(_, _):
            return "Response is not NSHTTPURLResponse"
        case .invalidStatusCode(let statusCode, _, _):
            return "Expected status code 200, got \(statusCode)"
        case .noDataReceived(_):
            return "No data received"
        //case .responseParseError(_, _, _):
        //    return "Error while parsing response"
        case .serverError(_, _, _):
            return "Telegram server returned an error"
        //case .noResult(_, _, _):
        //    return "No result in Telegram response"
        //case .resultParseError:
        //    return "Result couldn't be parsed"
        }
    }
}
