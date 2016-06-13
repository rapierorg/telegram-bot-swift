// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension TelegramBot {
	/// Perform synchronous request.
	/// - Returns: JsonObject on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> Result? {
		
		var retval: Result!
		let sem = dispatch_semaphore_create(0)!
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)!
		requestAsync(endpoint, parameters, queue: queue) {
			(result: Result?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: JsonObject on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?]?...) -> Result? {
		return requestSync(endpoint, mergeParameters(parameters))
	}
	
	/// Perform synchronous request.
	/// - Returns: array of JsonObjects on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> [Result]? {
		
		var retval: [Result]!
		let sem = dispatch_semaphore_create(0)!
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)!
		requestAsync(endpoint, parameters, queue: queue) {
			(result: [Result]?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			dispatch_semaphore_signal(sem)
		}
		NSRunLoop.current().waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: array of JsonObjects on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?]?...) -> [Result]? {
		return requestSync(endpoint, mergeParameters(parameters))
	}
	
	/// Perform asynchronous request.
	/// - Returns: JsonObject on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?] = [:], queue: dispatch_queue_t = dispatch_get_main_queue(), completion: ((result: Result?, error: DataTaskError?) -> ())?) {
		
		startDataTaskForEndpoint(endpoint, parameters: parameters) {
			json, error in
			var result: Result?
			if error == nil {
				result = Result(json: json)
			}
			dispatch_async(queue) {
				completion?(result: result, error: error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: JsonObject on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: dispatch_queue_t = dispatch_get_main_queue(), completion: ((result: Result?, error: DataTaskError?) -> ())?) {
		requestAsync(endpoint, mergeParameters(parameters), queue: queue, completion: completion)
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of JsonObjects on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?] = [:], queue: dispatch_queue_t = dispatch_get_main_queue(), completion: ((result: [Result]?, error: DataTaskError?) -> ())?) {
		
		startDataTaskForEndpoint(endpoint, parameters: parameters) {
			json, error in
			var resultArray = [Result]()
			if error == nil {
				resultArray.reserveCapacity(json.count)
				for resultJson in json.arrayValue {
					let result = Result(json: resultJson)
					resultArray.append(result)
				}
			}
			dispatch_async(queue) {
				completion?(result: resultArray, error: error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of JsonObjects on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result where Result: JsonObject>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: dispatch_queue_t = dispatch_get_main_queue(), completion: ((result: [Result]?, error: DataTaskError?) -> ())?) {
		return requestAsync(endpoint, mergeParameters(parameters), queue: queue, completion: completion)
	}
	
	/// Merge request parameters into a single dictionary. Nil parameters are ignored. Keys with nil values are also ignored.
	/// - Returns: merged parameters.
	private func mergeParameters(_ parameters: [ [String: Any?]? ]) -> [String: Any?] {
		var result = [String: Any?]()
		for p in parameters {
			guard let p = p else { continue }
			p.forEach { key, value in
				guard let value = value else { return }
				result.updateValue(value, forKey: key)
			}
		}
		return result
	}
}
