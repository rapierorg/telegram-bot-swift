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
    /// `errorHandler`'s completion block type
    /// - Seealso: `public var errorHandler: ErrorHandler?`
    public typealias ErrorHandler = (NSURLSessionDataTask, DataTaskError) -> ()
    
    private typealias DataTaskCompletion = (result: JSON)->()

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
    
    private let workQueue = dispatch_queue_create("com.zabiyaka.TelegramBot", DISPATCH_QUEUE_SERIAL)
    
    /// To handle network or parse errors,
    /// set a custom callback using this property.
    /// In a typical case this is not needed.
    ///
    /// `defaultErrorHandler` is used by default.
    public var errorHandler: ErrorHandler?
    
    /// Implements the default error handling logic. Consult
    /// `TelegramBot` class description for details.
    public lazy var defaultErrorHandler: ErrorHandler = {
        [weak self] task, error in
        
        guard let originalRequest = task.originalRequest else {
            fatalError("\(error)")
        }
        
        print("Will retry")
        
        // This closure is called from dataTask queue,
        // but startDataTaskForRequest will start the new
        // dataTask from workQueue
        self?.startDataTaskForRequest(originalRequest)
    }
    
    /// Default handling of network and parse errors.
    public static let defaultSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        return NSURLSession(configuration: configuration)
    }()
    
    private static var completionKey = "dataTaskCompletionHandler"
    
    /// Creates an instance of Telegram Bot.
    /// - Parameter token: A unique authentication token.
    /// - Parameter session: `NSURLSession` instance, a session with `ephemeralSessionConfiguration` is used by default.
    init(token: String, session: NSURLSession = defaultSession) {
        self.token = token
        self.session = session
        self.errorHandler = defaultErrorHandler
    }
    
    deinit {
        print("Deinit")
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
        let associatedData = RequestAssociatedData<DataTaskCompletion>(completion)
        objc_setAssociatedObject(request, &TelegramBot.completionKey, associatedData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        startDataTaskForRequest(request)
    }
    
    private func startDataTaskForRequest(request: NSURLRequest) {
        // This function can be called from main queue (when
        // call is initiated by user) or from dataTask queue (when
        // automatically retrying).
        // Dispatch calls to serial workQueue.
        dispatch_async(self.workQueue) {
            var task: NSURLSessionDataTask?
            task = self.session.dataTaskWithRequest(request) { dataOrNil, responseOrNil, errorOrNil in
                self.urlSessionDataTaskCompletion(task!, dataOrNil, responseOrNil, errorOrNil)
            }
            task?.resume()
        }
    }
    
    private func urlSessionDataTaskCompletion(task: NSURLSessionDataTask, _ dataOrNil: NSData?, _ responseOrNil: NSURLResponse?, _ errorOrNil: NSError?) {
        
        if let error = errorOrNil {
            errorHandler?(task, .GenericError(
                data: dataOrNil, response: responseOrNil, error: error))
            return
        }
        
        guard let response = responseOrNil as? NSHTTPURLResponse else {
            errorHandler?(task, .InvalidResponseType(
                data: dataOrNil, response: responseOrNil))
            return
        }
        
        if response.statusCode != 200 {
            errorHandler?(task, .InvalidStatusCode(
                statusCode: response.statusCode,
                data: dataOrNil, response: response))
            return
        }
        
        guard let data = dataOrNil else {
            errorHandler?(task, .NoDataReceived(
                response: response))
            return
        }
        
        let json = JSON(data: data)
        
        guard let telegramResponse = Response(json: json) else {
            errorHandler?(task, .ResponseParseError(
                json: json, data: data, response: response))
            return
        }
        
        if !telegramResponse.ok {
            errorHandler?(task, .ServerError(
                telegramResponse: telegramResponse, data: data, response: response))
            return
        }
        
        guard let result = telegramResponse.result else {
            errorHandler?(task, .NoResult(
                telegramResponse: telegramResponse, data: data, response: response))
            return
        }
        
        // If user completion handler is attached to this
        // request, call it. Completion handler is stored as
        // an associated property and not passed as a function
        // argument to support retrying.
        if let originalRequest = task.originalRequest {
            if let associatedData = objc_getAssociatedObject(originalRequest, &TelegramBot.completionKey) as? RequestAssociatedData<DataTaskCompletion> {
                associatedData.completion?(result: result)
            }
        }
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
