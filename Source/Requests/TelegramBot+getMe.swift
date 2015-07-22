//
// TelegramBot+getMe.swift
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

extension TelegramBot {
    
    /// A simple method for testing your bot's auth token. Requires no parameters.
    ///
    /// This is an asynchronous version of the method,
    /// a blocking one is also available.
    ///
    /// - Parameter completion: Completion handler which will be called on main
    ///                         queue by default. The queue can be overridden
    ///                         by setting `queue` property of TelegramBot.
    /// - Returns: Basic information about the bot in form of a `User` object.
    ///            Null on error, in which case `error` contains the details.
    /// - SeeAlso: `func getMe() -> User?`
    func getMe(completion: (user: User?, error: DataTaskError?)->()) {
        getMe(queue, completion: completion)
    }
    
    /// A simple method for testing your bot's auth token. Requires no parameters.
    ///
    /// This is a blocking version of the method,
    /// an asynchronous one is also available.
    ///
    /// - Returns: Basic information about the bot in form of a `User` object.
    ///            Null on error, in which case details can be obtained using
    ///            `lastError` property.
    /// - SeeAlso: `func getMe(completion:)->()`
    func getMe() -> User? {
        var result: User!
        let sem = dispatch_semaphore_create(0)
        getMe(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                user, error in
            result = user
            self.lastError = error
            dispatch_semaphore_signal(sem)
        }
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        return result
    }

    private func getMe(queue: dispatch_queue_t, completion: (user: User?, error: DataTaskError?)->()) {
        startDataTaskForEndpoint("getMe") {
                result, dataTaskError in
            var error = dataTaskError
            var user: User?
            if error == nil {
                user = User(json: result)
                if user == nil {
                    error = .ResultParseError(json: result)
                }
            }
            dispatch_async(queue) {
                completion(user: user, error: error)
            }
        }
    }
}
