//
// TelegramBot.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation
import Dispatch

import CCurl

public class TelegramBot {
    internal typealias DataTaskCompletion = (_ json: JSON, _ error: DataTaskError?)->()

	public typealias RequestParameters = [String: Any?]
	
    /// Telegram server URL.
    public var url = "https://api.telegram.org"
    
    /// Unique authentication token obtained from BotFather.
    public var token: String
	
	/// Default request parameters
	public var defaultParameters = [String: RequestParameters]()
	
    /// In case of network errors or server problems,
    /// do not report the errors and try to reconnect
    /// automatically.
    public var autoReconnect: Bool = true

    /// Offset for long polling.
    public var nextOffset: Int?

    /// Number of updates to fetch by default.
    public var defaultUpdatesLimit: Int = 100

    /// Default getUpdates timeout in seconds.
    public var defaultUpdatesTimeout: Int = 60
    
    // Should probably be a LinkedList, but it won't be longer than
    // 100 elements anyway.
    var unprocessedUpdates: [Update]
    
    /// Queue for callbacks in asynchronous versions of requests.
    public var queue = DispatchQueue.main
    
    /// Last error for use with synchronous requests.
    public var lastError: DataTaskError?
    
    /// Logging function. Defaults to `print`.
    public var logger: (_ text: String) -> () = { print($0) }
    
    /// Defines reconnect delay in seconds when requesting updates. Can be overridden.
    ///
    /// - Parameter retryCount: Number of reconnect retries associated with `request`.
    /// - Returns: Seconds to wait before next reconnect attempt. Return `0.0` for instant reconnect.
    public var reconnectDelay: (_ retryCount: Int) -> Double = { retryCount in
        switch retryCount {
        case 0: return 0.0
        case 1: return 1.0
        case 2: return 2.0
        case 3: return 5.0
        case 4: return 10.0
        case 5: return 20.0
        default: break
        }
        return 30.0
    }
    
    /// Equivalent of calling `getMe()`
    ///
    /// This function will block until the request is finished.
    public lazy var user: User = {
        guard let me = self.getMeSync() else {
            print("Unable to fetch bot information: \(self.lastError.unwrapOptional)")
            exit(1)
        }
        return me
    }()
    
    /// Equivalent of calling `user.username` and unwrapping it
    ///
    /// This function will block until the request is finished.
    public lazy var username: String = {
        guard let username = self.user.username else {
            fatalError("Unable to fetch bot username")
        }
        return username
    }()
    
    /// Equivalent of calling `BotName(username: username)`
    ///
    /// This function will block until the request is finished.
    public lazy var name: BotName = BotName(username: self.username)
    
    /// Creates an instance of Telegram Bot.
    /// - Parameter token: A unique authentication token.
    /// - Parameter fetchBotInfo: If true, issue a blocking `getMe()` call and cache the bot information. Otherwise it will be lazy-loaded when needed. Defaults to true.
    /// - Parameter session: `NSURLSession` instance, a session with `ephemeralSessionConfiguration` is used by default.
    public init(token: String, fetchBotInfo: Bool = true) {
        self.token = token
        self.unprocessedUpdates = []
        if fetchBotInfo {
            _ = user // Load the lazy user variable
        }
    }
    
    deinit {
        //print("Deinit")
    }
    
    /// Returns next update for this bot.
    ///
    /// Blocks while fetching updates from the server.
    ///
	/// - Parameter mineOnly: Ignore commands not addressed to me, i.e. `/command@another_bot`.
    /// - Returns: `Update`. `Nil` on error, in which case details
    ///   can be obtained from `lastError` property.
	public func nextUpdateSync(onlyMine: Bool = true) -> Update? {
        while let update = nextUpdateSync() {
			if onlyMine {
	            if let message = update.message, !message.addressed(to: self) {
					continue
				}
			}
			
            return update
        }
        return nil
    }
    
    /// Waits for specified number of seconds. Message loop won't be blocked.
    ///
    /// - Parameter wait: Seconds to wait.
    public func wait(seconds: Double) {
        let sem = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds) {
            sem.signal()
        }
        RunLoop.current.waitForSemaphore(sem)
    }
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests (getMe, getStatus etc).
    internal func startDataTaskForEndpoint(_ endpoint: String, completion: @escaping DataTaskCompletion) {
        startDataTaskForEndpoint(endpoint, parameters: [:], completion: completion)
    }
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests.
    internal func startDataTaskForEndpoint(_ endpoint: String, parameters: [String: Any?], completion: @escaping DataTaskCompletion) {
        let endpointUrl = urlForEndpoint(endpoint)
        
        // If parameters contain values of type InputFile, use  multipart/form-data for sending them.
        var hasAttachments = false
        for value in parameters.values {
            if value is InputFile {
                hasAttachments = true
                break
            }
        }

        let contentType: String
        let requestDataOrNil: Data?
        if hasAttachments {
            let boundary = HTTPUtils.generateBoundaryString()
            contentType = "multipart/form-data; boundary=\(boundary)"
            requestDataOrNil = HTTPUtils.createMultipartFormDataBody(with: parameters, boundary: boundary)
            //try! requestDataOrNil!.write(to: URL(fileURLWithPath: "/tmp/dump.bin"))
            logger("endpoint: \(endpoint), sending parameters as multipart/form-data")
        } else {
            contentType = "application/x-www-form-urlencoded"
            let encoded = HTTPUtils.formUrlencode(parameters)
            requestDataOrNil = encoded.data(using: .utf8)
            logger("endpoint: \(endpoint), data: \(encoded)")
        }
        requestDataOrNil?.append(0)

        guard let requestData = requestDataOrNil else {
            completion(nil, .invalidRequest)
            return
        }
        // -1 for '\0'
        let byteCount = requestData.count - 1
        
        DispatchQueue.global().async {
            requestData.withUnsafeBytes { (bytes: UnsafePointer<UInt8>)->Void in
                self.curlPerformRequest(endpointUrl: endpointUrl, contentType: contentType, requestBytes: bytes, byteCount: byteCount, completion: completion)
            }
        }
    }
    
    /// Note: performed on global queue
    private func curlPerformRequest(endpointUrl: URL, contentType: String, requestBytes: UnsafePointer<UInt8>, byteCount: Int, completion: @escaping DataTaskCompletion) {
        var callbackData = WriteCallbackData()
        
        guard let curl = curl_easy_init() else {
            completion(nil, .libcurlInitError)
            return
        }
        defer { curl_easy_cleanup(curl) }
        
        curl_easy_setopt_string(curl, CURLOPT_URL, endpointUrl.absoluteString)
        //curl_easy_setopt_int(curl, CURLOPT_SAFE_UPLOAD, 1)
        curl_easy_setopt_int(curl, CURLOPT_POST, 1)
        curl_easy_setopt_binary(curl, CURLOPT_POSTFIELDS, requestBytes)
        curl_easy_setopt_int(curl, CURLOPT_POSTFIELDSIZE, Int32(byteCount))
        
        var headers: UnsafeMutablePointer<curl_slist>? = nil
        headers = curl_slist_append(headers, "Content-Type: \(contentType)")
        curl_easy_setopt_slist(curl, CURLOPT_HTTPHEADER, headers)
        defer { curl_slist_free_all(headers) }
        
        let writeFunction: curl_write_callback = { (ptr, size, nmemb, userdata) -> Int in
            let count = size * nmemb
            if let writeCallbackDataPointer = userdata?.assumingMemoryBound(to: WriteCallbackData.self) {
                let writeCallbackData = writeCallbackDataPointer.pointee
                ptr?.withMemoryRebound(to: UInt8.self, capacity: count) {
                    writeCallbackData.data.append(&$0.pointee, count: count)
                }
            }
            return count
        }
        curl_easy_setopt_write_function(curl, CURLOPT_WRITEFUNCTION, writeFunction)
        curl_easy_setopt_pointer(curl, CURLOPT_WRITEDATA, &callbackData)
        //curl_easy_setopt_int(curl, CURLOPT_VERBOSE, 1)
        let code = curl_easy_perform(curl)
        guard code == CURLE_OK else {
            reportCurlError(code: code, completion: completion)
            return
        }
        
        //let result = String(data: callbackData.data, encoding: .utf8)
        //print("CURLcode=\(code.rawValue) result=\(result.unwrapOptional)")
        
        guard code != CURLE_ABORTED_BY_CALLBACK else {
            completion(nil, .libcurlAbortedByCallback)
            return
        }
        
        var httpCode: Int = 0
        guard CURLE_OK == curl_easy_getinfo_long(curl, CURLINFO_RESPONSE_CODE, &httpCode) else {
            reportCurlError(code: code, completion: completion)
            return
        }
        let data = callbackData.data
        let json = JSON(data: data)
        let telegramResponse = Response(internalJson: json)
        
        guard httpCode == 200 else {
            completion(nil, .invalidStatusCode(statusCode: httpCode, telegramResponse: telegramResponse, data: data))
            return
        }
        
        guard !data.isEmpty else {
            completion(nil, .noDataReceived)
            return
        }
        
        if !telegramResponse.ok {
            completion(nil, .serverError(telegramResponse: telegramResponse, data: data))
            return
        }
        
        completion(telegramResponse.result, nil)
    }
    
    private func reportCurlError(code: CURLcode, completion: @escaping DataTaskCompletion) {
        let failReason = String(cString: curl_easy_strerror(code), encoding: .utf8) ?? "unknown error"
        //print("Request failed: \(failReason)")
        completion(nil, .libcurlError(code: code, description: failReason))
    }
    
    private func urlForEndpoint(_ endpoint: String) -> URL {
        let tokenUrlencoded = token.urlQueryEncode()
        let endpointUrlencoded = endpoint.urlQueryEncode()
        let urlString = "\(url)/bot\(tokenUrlencoded)/\(endpointUrlencoded)"
        guard let result = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return result
    }
}
