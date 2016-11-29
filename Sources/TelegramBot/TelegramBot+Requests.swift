// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import Dispatch

extension TelegramBot {
	/// Perform synchronous request.
	/// - Returns: JsonConvertible on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> Result? where Result: JsonConvertible {
		
		var retval: Result!
		let sem = DispatchSemaphore(value: 0)
		let queue = DispatchQueue.global()
		requestAsync(endpoint, parameters, queue: queue) {
			(result: Result?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			sem.signal()
		}
		RunLoop.current.waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: JsonConvertible on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result>(_ endpoint: String, _ parameters: [String: Any?]?...) -> Result? where Result: JsonConvertible {
		return requestSync(endpoint, mergeParameters(parameters))
	}
	
	/// Perform synchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> [Result]? where Result: JsonConvertible {
		
		var retval: [Result]!
		let sem = DispatchSemaphore(value: 0)
		let queue = DispatchQueue.global()
		requestAsync(endpoint, parameters, queue: queue) {
			(result: [Result]?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			sem.signal()
		}
		RunLoop.current.waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<Result>(_ endpoint: String, _ parameters: [String: Any?]?...) -> [Result]? where Result: JsonConvertible {
		return requestSync(endpoint, mergeParameters(parameters))
	}
	
	/// Perform asynchronous request.
	/// - Returns: JsonConvertible on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result>(_ endpoint: String, _ parameters: [String: Any?] = [:], queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: Result?, _ error: DataTaskError?) -> ())?) where Result: JsonConvertible {
		
		startDataTaskForEndpoint(endpoint, parameters: parameters) {
			json, error in
			var result: Result?
			if error == nil {
				result = Result(json: json)
			}
			queue.async() {
				completion?(result, error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: JsonConvertible on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: Result?, _ error: DataTaskError?) -> ())?) where Result: JsonConvertible {
		requestAsync(endpoint, mergeParameters(parameters), queue: queue, completion: completion)
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result>(_ endpoint: String, _ parameters: [String: Any?] = [:], queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: [Result]?, _ error: DataTaskError?) -> ())?) where Result: JsonConvertible {
		
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
			queue.async() {
                completion?(error == nil ? resultArray : nil, error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `error` contains the details.
	public func requestAsync<Result>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: [Result]?, _ error: DataTaskError?) -> ())?) where Result: JsonConvertible {
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
