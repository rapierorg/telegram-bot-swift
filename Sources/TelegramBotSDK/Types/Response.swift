//
// Response.swift
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


/// Response to Bot API request.
public struct Response: JsonConvertible, InternalJsonConvertible {
    public init(json: Any) {
        self.init(internalJson: JSON(json))
    }

	/// Original JSON for fields not yet added to Swift structures
    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
    internal var internalJson: JSON
	
	/// If `ok` equals true, the request was successful and the result of the query can be found in the `result` field. In case of an unsuccessful request, ‘ok’ equals false and the error is explained in the ‘errorDescription’.
	public var ok: Bool {
		get { return internalJson["ok"].boolValue }
		set { internalJson["ok"].boolValue = newValue }
	}
		
    /// *Optional.* Error description.
	public var description: String? {
		get { return internalJson["description"].string }
		set { internalJson["description"].string = newValue }
	}
		
    /// *Optional.* Error code. Its contents are subject to change in the future.
	public var error_code: Int? {
		get { return internalJson["error_code"].int }
		set { internalJson["error_code"].int = newValue }
	}
		
    /// *Optional.* Result.
	internal var result: JSON {
		get { return internalJson["result"] }
		set { internalJson["result"] = newValue }
	}
	
	internal init(internalJson: JSON = [:]) {
		self.internalJson = internalJson
	}
}
