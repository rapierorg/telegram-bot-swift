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
import SwiftyJSON

/// Response to Bot API request.
public struct Response: JsonConvertible {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// If `ok` equals true, the request was successful and the result of the query can be found in the `result` field. In case of an unsuccessful request, ‘ok’ equals false and the error is explained in the ‘errorDescription’.
	public var ok: Bool {
		get { return json["ok"].boolValue }
		set { json["ok"].boolValue = newValue }
	}
		
    /// *Optional.* Error description.
	public var description: String? {
		get { return json["description"].string }
		set { json["description"].string = newValue }
	}
		
    /// *Optional.* Error code. Its contents are subject to change in the future.
	public var error_code: Int? {
		get { return json["error_code"].int }
		set { json["error_code"].int = newValue }
	}
		
    /// *Optional.* Result.
	public var result: JSON {
		get { return json["result"] }
		set { json["result"] = newValue }
	}
	
	public init(json: JSON = [:]) {
		self.json = json
	}
}
