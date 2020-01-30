//
// TelegramBot+Requests.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation
import Dispatch

extension TelegramBot {
	/// Perform synchronous request.
	/// - Returns: Decodable  on success. Nil on error, in which case `lastError` contains the details.
	internal func requestSync<TResult>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> TResult? where TResult: Decodable {
		
		var retval: TResult!
		let sem = DispatchSemaphore(value: 0)
		let queue = DispatchQueue.global()
		requestAsync(endpoint, parameters, queue: queue) {
			(result: TResult?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			sem.signal()
		}
		RunLoop.current.waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: Decodable  on success. Nil on error, in which case `lastError` contains the details.
	internal func requestSync<TResult>(_ endpoint: String, _ parameters: [String: Any?]?...) -> TResult? where TResult: Decodable {
		return requestSync(endpoint, mergeParameters(parameters))
	}
	
	/*/// Perform synchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `lastError` contains the details.
	internal func requestSync<TResult>(_ endpoint: String, _ parameters: [String: Any?] = [:]) -> [TResult]? where TResult: Decodable {
		
		var retval: [TResult]!
		let sem = DispatchSemaphore(value: 0)
		let queue = DispatchQueue.global()
		requestAsync(endpoint, parameters, queue: queue) {
			(result: [TResult]?, error: DataTaskError?) in
			retval = result
			self.lastError = error
			sem.signal()
		}
		RunLoop.current.waitForSemaphore(sem)
		return retval
	}
	
	/// Perform synchronous request.
	/// - Returns: array of JsonConvertibles on success. Nil on error, in which case `lastError` contains the details.
	public func requestSync<TResult>(_ endpoint: String, _ parameters: [String: Any?]?...) -> [TResult]? where TResult: Decodable {
		return requestSync(endpoint, mergeParameters(parameters))
	}*/
	
	/// Perform asynchronous request.
	/// - Returns: Decodable  on success. Nil on error, in which case `error` contains the details.
    internal func requestAsync<TResult>(_ endpoint: String, _ parameters: [String: Encodable?] = [:], queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: TResult?, _ error: DataTaskError?) -> ())?) where TResult: Decodable {
		
        startDataTaskForEndpoint(endpoint, parameters: parameters, resultType: TResult.self) {
			rawResult, error in
            var resultValid = false
            if (rawResult as? TResult?) != nil {
                resultValid = true
            }
			queue.async() {
                completion?(resultValid ? rawResult as! TResult? : nil, error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: Decodable  on success. Nil on error, in which case `error` contains the details.
	internal func requestAsync<TResult>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: TResult?, _ error: DataTaskError?) -> ())?) where TResult: Decodable {
		requestAsync(endpoint, mergeParameters(parameters), queue: queue, completion: completion)
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of Decodable  on success. Nil on error, in which case `error` contains the details.
	internal func requestAsync<TResult>(_ endpoint: String, _ parameters: [String: Encodable?] = [:], queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: [TResult]?, _ error: DataTaskError?) -> ())?) where TResult: Decodable {
		
        startDataTaskForEndpoint(endpoint, parameters: parameters, resultType: [TResult].self) {
			rawResult, error in
            var resultValid = false
            if (rawResult as? [TResult]?) != nil {
                resultValid = true
            }
			queue.async() {
                completion?(resultValid ? rawResult as! [TResult]? : nil, error)
			}
		}
	}
	
	/// Perform asynchronous request.
	/// - Returns: array of Decodable  on success. Nil on error, in which case `error` contains the details.
	internal func requestAsync<TResult>(_ endpoint: String, _ parameters: [String: Any?]?..., queue: DispatchQueue = DispatchQueue.main, completion: ((_ result: [TResult]?, _ error: DataTaskError?) -> ())?) where TResult: Decodable {
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
