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
    
    /// Queue for callbacks
    public var queue = dispatch_get_main_queue()
    
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
            print("getMe: json: \(json)")
            guard let user = User(json: json) else {
                fatalError("getMe: JSON parse error")
            }
            dispatch_async(self.queue) {
                completion(user: user)
            }
        }
    }

    func getMe() -> User {
        return User()
    }
    
    private func startDataTaskForEndpoint(endpoint: String, parameters: [String: AnyObject?], completion: DataTaskCompletion) {
        let endpointUrl = urlForEndpoint(endpoint)
        let data = parameters.formUrlencode()
        
        let request = NSMutableURLRequest(URL: endpointUrl)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.HTTPMethod = "POST"
        request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                fatalError("dataTaskWithRequest: error: \(error)")
            }
            
            guard let response = response as? NSHTTPURLResponse else {
                fatalError("Response is not NSHTTPURLResponse")
            }
            
            if response.statusCode != 200 {
                fatalError("Expected status code 200, got \(response.statusCode)")
            }
            
            guard let data = data else {
                fatalError("No data received")
            }
            
            let json = JSON(data: data)
            completion(json: json)
        }
        task?.resume()
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
