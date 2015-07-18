//
// TelegramBot.swift
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

public class TelegramBot {
    
    /// Telegram server URL.
    public var url = "https://api.telegram.org"
    
    /// Unique authentication token obtained from BotFather.
    public var token: String

    /// Session. By default, configured with ephemeralSessionConfiguration().
    public var session: NSURLSession

    /// Offset for long polling
    public var nextOffset = 0
    
    public static let defaultSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        return NSURLSession(configuration: configuration)
    }()
    
    typealias DataTaskCompletion = (json: JSON)->()
    
    init(token: String, session: NSURLSession = defaultSession) {
        self.token = token
        self.session = session
    }
    
    func getMe(completion: (user: User)->()) {
        startDataTaskForEndpoint("getMe") { json in
            print(json)
            completion(user: User())
        }
    }

    func getMe() -> User {
        return User()
    }
    
    private func startDataTaskForEndpoint(endpoint: String,
        parameters: [String: AnyObject?], completion: DataTaskCompletion) {
        let endpointUrl = urlForEndpoint(endpoint)
        let data = parameters.formUrlencode()
        completion(json: JSON(""))
    }

    private func startDataTaskForEndpoint(endpoint: String, completion: DataTaskCompletion) {
        startDataTaskForEndpoint(endpoint, parameters: [:], completion: completion)
    }

    private func urlForEndpoint(endpoint: String) -> NSURL {
        let tokenUrlencoded = token.urlQueryEncode()
        let endpointUrlencoded = endpoint.urlQueryEncode()
        let urlString = "\(url)/bot\(tokenUrlencoded)/\(endpointUrlencoded)"
        guard let result = NSURL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return result
    }
}
