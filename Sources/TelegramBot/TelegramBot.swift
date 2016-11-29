// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import Dispatch
import SwiftyJSON
import Dispatch

public class TelegramBot {
    /// `errorHandler`'s completion block type
    /// - SeeAlso: `public var errorHandler: ErrorHandler?`
    public typealias ErrorHandler = (URLSessionDataTask, DataTaskError) -> ()
    
    public typealias DataTaskCompletion = (_ json: JSON, _ error: DataTaskError?)->()

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

    /// A list of errors to handle automatically if `autoReconnect` is on.
    public static var autoReconnectCodes: Set<Int> = [
        //NSURLErrorUnknown,
        //NSURLErrorCancelled,
        //NSURLErrorBadURL,
        NSURLErrorTimedOut,
        //NSURLErrorUnsupportedURL,
        NSURLErrorCannotFindHost,
        NSURLErrorCannotConnectToHost,
        NSURLErrorNetworkConnectionLost,
        NSURLErrorDNSLookupFailed,
        //NSURLErrorHTTPTooManyRedirects,
        NSURLErrorResourceUnavailable,
        NSURLErrorNotConnectedToInternet,
        //NSURLErrorRedirectToNonExistentLocation,
        NSURLErrorBadServerResponse,
        //NSURLErrorUserCancelledAuthentication,
        //NSURLErrorUserAuthenticationRequired,
        //NSURLErrorZeroByteResource,
        //NSURLErrorCannotDecodeRawData,
        //NSURLErrorCannotDecodeContentData,
        //NSURLErrorCannotParseResponse,
        //@available(OSX 10.11, *)
        //NSURLErrorAppTransportSecurityRequiresSecureConnection,
        //NSURLErrorFileDoesNotExist,
        //NSURLErrorFileIsDirectory,
        //NSURLErrorNoPermissionsToReadFile,
        //@available(OSX 10.5, *)
        //NSURLErrorDataLengthExceedsMaximum,
        // SSL errors
        NSURLErrorSecureConnectionFailed,
        //NSURLErrorServerCertificateHasBadDate,
        //NSURLErrorServerCertificateUntrusted,
        //NSURLErrorServerCertificateHasUnknownRoot,
        //NSURLErrorServerCertificateNotYetValid,
        //NSURLErrorClientCertificateRejected,
        //NSURLErrorClientCertificateRequired,
        NSURLErrorCannotLoadFromNetwork,
        // Download and file I/O errors
        //NSURLErrorCannotCreateFile,
        //NSURLErrorCannotOpenFile,
        //NSURLErrorCannotCloseFile,
        //NSURLErrorCannotWriteToFile,
        //NSURLErrorCannotRemoveFile,
        //NSURLErrorCannotMoveFile,
        NSURLErrorDownloadDecodingFailedMidStream,
        NSURLErrorDownloadDecodingFailedToComplete,
        //@available(OSX 10.7, *)
        NSURLErrorInternationalRoamingOff,
        //@available(OSX 10.7, *)
        NSURLErrorCallIsActive,
        //@available(OSX 10.7, *)
        NSURLErrorDataNotAllowed,
        //@available(OSX 10.7, *)
        //NSURLErrorRequestBodyStreamExhausted,
        //@available(OSX 10.10, *)
        //NSURLErrorBackgroundSessionRequiresSharedContainer,
        //@available(OSX 10.10, *)
        NSURLErrorBackgroundSessionInUseByAnotherProcess,
        //@available(OSX 10.10, *)
        NSURLErrorBackgroundSessionWasDisconnected,
    ]
    
    /// Session. By default, configured with ephemeralSessionConfiguration().
    public var session: URLSession

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
    
    private let workQueue = DispatchQueue(label: "com.zabiyaka.TelegramBot")
    
    /// To handle network or parse errors,
    /// set a custom callback using this property.
    /// In a typical case this is not needed.
    ///
    /// `defaultErrorHandler` is used by default.
    public var errorHandler: ErrorHandler?
    
    /// Defines reconnect delay in seconds depending on `retryCount`. Can be overridden.
    ///
    /// Used by default `errorHandler` implementation.
    ///
    /// - Reconnect instantly on first error.
    /// - Add 2 seconds delay for each failed attempt up to 60 seconds maximum to avoid
    /// spamming the server.
    ///
    /// Warning: called on `dataTask` queue.
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
    
    /// Implements the default error handling logic. Consult
    /// `TelegramBot` class description for details.
    public lazy var defaultErrorHandler: ErrorHandler = {
        [weak self] task, error in
        
        guard let originalRequest = task.originalRequest else {
            fatalError("\(error)")
        }
 
        guard let taskAssociatedData = task.associatedData else {
            fatalError("\(error)")
        }
        
        // Strong capture the self if it's still not nil
        guard let actualSelf = self else { return }

        if !actualSelf.autoReconnect {
            taskAssociatedData.completion?(nil, error)
            return
        }
        
        // Report errors back to user except the ones we know how to handle
        switch error {
        case let .genericError(_, _, networkError as NSError)
            where networkError.domain == NSURLErrorDomain &&
                TelegramBot.autoReconnectCodes.contains(networkError.code):
            print("Network error: \(networkError.localizedDescription)")
            break
        case let .invalidStatusCode(statusCode, _, _) where statusCode != 401: // == 502
            print("Error: \(error.debugDescription)")
            break
        default:
            taskAssociatedData.completion?(nil, error)
            return
        }
        
        // Known error, reconnect:
        let retryCount = taskAssociatedData.retryCount
        let reconnectDelay = actualSelf.reconnectDelay(retryCount)
        taskAssociatedData.retryCount += 1
        
        // This closure will be called from dataTask queue,
        // but startDataTaskForRequest will start the new
        // dataTask from workQueue.
        if reconnectDelay == 0.0 {
            print("Reconnect attempt \(taskAssociatedData.retryCount), will retry at once")
            actualSelf.startDataTaskForRequest(originalRequest, associateTaskWithData: taskAssociatedData)
        } else {
            print("Reconnect attempt \(taskAssociatedData.retryCount), will retry after \(reconnectDelay) sec")
            // Be aware that dispatch_after does NOT work correctly with serial queues.
            // The queue will perform async blocks BEFORE those inserted via dispatch_after.
            // So, use global queue for the pause, then execute the actual request on workQueue.
            DispatchQueue.global().asyncAfter(
                deadline: DispatchTime.now() + reconnectDelay) {
                actualSelf.startDataTaskForRequest(originalRequest, associateTaskWithData: taskAssociatedData)
            }
        }
    }
    
    /// Default handling of network and parse errors.
    public static let defaultSession: URLSession = {
        #if os(Linux)
        let configuration = URLSessionConfiguration.default
        #else
        let configuration = URLSessionConfiguration.ephemeral
        #endif
        return URLSession(configuration: configuration)
    }()
    
    /// Equivalent of calling `getMe()`
    ///
    /// This function will block until the request is finished.
    public lazy var user: User = {
        guard let me = self.getMeSync() else {
            fatalError("Unable to fetch bot information: \(self.lastError.unwrapOptional)")
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
    public init(token: String, fetchBotInfo: Bool = true, session: URLSession = defaultSession) {
        self.token = token
        self.session = session
        self.unprocessedUpdates = []
        self.errorHandler = defaultErrorHandler
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
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests (getMe, getStatus etc).
    public func startDataTaskForEndpoint(_ endpoint: String, completion: @escaping DataTaskCompletion) {
        startDataTaskForEndpoint(endpoint, parameters: [:], completion: completion)
    }
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests.
    public func startDataTaskForEndpoint(_ endpoint: String, parameters: [String: Any?], completion: @escaping DataTaskCompletion) {
        let endpointUrl = urlForEndpoint(endpoint)
        let data = HTTPUtils.formUrlencode(parameters)
		print("endpoint: \(endpoint), data: \(data)")
        
        var request = URLRequest(url: endpointUrl)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "POST"
		request.httpBody = data.data(using: String.Encoding.utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let taskAssociatedData = TaskAssociatedData(completion)
        startDataTaskForRequest(request, associateTaskWithData: taskAssociatedData)
    }
    
    /// Use this function for implementing retrying in
    /// custom `errorHandler`.
    ///
    /// See `defaultErrorHandler` implementation for an example.
    public func startDataTaskForRequest(_ request: URLRequest, associateTaskWithData taskAssociatedData: TaskAssociatedData) {
        // This function can be called from main queue (when
        // call is initiated by user) or from dataTask queue (when
        // automatically retrying).
        // Dispatch calls to serial workQueue.
        self.workQueue.async {
            var task: URLSessionDataTask?
			task = self.session.dataTask(with: request) { dataOrNil, responseOrNil, errorOrNil in
				self.urlSessionDataTaskCompletion(task!, dataOrNil, responseOrNil, errorOrNil)
            }
            if let t = task {
                t.associatedData = taskAssociatedData
                t.resume()
            }
        }
    }
		
    private func urlSessionDataTaskCompletion(_ task: URLSessionDataTask, _ dataOrNil: Data?, _ responseOrNil: URLResponse?, _ errorOrNil: Error?) {
        
        if let error = errorOrNil {
            errorHandler?(task, .genericError(
                data: dataOrNil, response: responseOrNil, error: error))
            return
        }
        
        guard let response = responseOrNil as? HTTPURLResponse else {
            errorHandler?(task, .invalidResponseType(
                data: dataOrNil, response: responseOrNil))
            return
        }
        
        if response.statusCode != 200 {
            errorHandler?(task, .invalidStatusCode(
                statusCode: response.statusCode,
                data: dataOrNil, response: response))
            return
        }
        
        guard let data = dataOrNil else {
            errorHandler?(task, .noDataReceived(
                response: response))
            return
        }
        
        let json = JSON(data: data)
        
        /*guard*/ let telegramResponse = Response(json: json) /*else {
            errorHandler?(task, .ResponseParseError(
                json: json, data: data, response: response))
            return
        }*/
        
        if !telegramResponse.ok {
            errorHandler?(task, .serverError(
                telegramResponse: telegramResponse, data: data, response: response))
            return
        }
        
        /*guard*/ let result = telegramResponse.result /*else {
            errorHandler?(task, .NoResult(
                telegramResponse: telegramResponse, data: data, response: response))
            return
        }*/

        // If user completion handler is attached to this
        // task, call it. Completion handler is stored as
        // an associated property and not passed as a function
        // argument to support retrying.
        if let taskAssociatedData = task.associatedData {
            
            // Success
            if taskAssociatedData.retryCount != 0 {
                taskAssociatedData.retryCount = 0
                print("Reconnected to Telegram server")
            }

            taskAssociatedData.completion?(result, nil)
        }
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
