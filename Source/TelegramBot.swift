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
    
    /// Queue for callbacks in asynchronous versions of requests.
    public var queue = dispatch_get_main_queue()
    
    public static let defaultSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        return NSURLSession(configuration: configuration)
    }()
    
    typealias DataTaskCompletion = (result: JSON)->()
    
    /// Creates an instance of Telegram Bot.
    /// - Parameter token: A unique authentication token.
    /// - Parameter session: `NSURLSession` instance, a session with `ephemeralSessionConfiguration` is used by default.
    init(token: String, session: NSURLSession = defaultSession) {
        self.token = token
        self.session = session
    }
    
    /// A simple method for testing your bot's auth token. Requires no parameters.
    ///
    /// This is an asynchronous version of the method,
    /// a blocking one is also available.
    ///
    /// - Parameter completion: Completion handler which is called on main queue by default. The queue can be overridden by setting `queue` property of TelegramBot.
    /// - Returns: Basic information about the bot in form of a `User` object.
    /// - Seealso: `func getMe() -> User`
    func getMe(completion: (user: User)->()) {
        getMe(self.queue, completion: completion)
    }

    /// A simple method for testing your bot's auth token. Requires no parameters.
    ///
    /// This is a blocking version of the method,
    /// an asynchronous one is also available.
    ///
    /// - Returns: Basic information about the bot in form of a `User` object.
    /// - Seealso: `func getMe(completion: (user: User)->())`
    func getMe() -> User {
        var result: User!
        let sem = dispatch_semaphore_create(0)
        getMe(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { user in
            result = user
            dispatch_semaphore_signal(sem)
        }
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }
    
    private func getMe(queue: dispatch_queue_t, completion: (user: User)->()) {
        startDataTaskForEndpoint("getMe") { result in
            guard let user = User(json: result) else {
                fatalError("getMe: JSON parse error")
            }
            dispatch_async(queue) {
                completion(user: user)
            }
        }
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
                fatalError("dataTaskWithRequest: error: \(error.localizedDescription)")
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
            
            guard let telegramResponse = Response(json: json) else {
                fatalError("Error while parsing response")
            }
            
            if !telegramResponse.ok {
                fatalError("Telegram server returned an error")
            }
            
            guard let result = telegramResponse.result else {
                fatalError("No results in Telegram response")
            }
            
            // TODO: raw result hook
            
            completion(result: result)
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
