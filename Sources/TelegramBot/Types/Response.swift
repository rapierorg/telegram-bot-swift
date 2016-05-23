// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Response to Bot API request.
public class Response: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
	/// If `ok` equals true, the request was successful and the result of the query can be found in the `result` field. In case of an unsuccessful request, ‘ok’ equals false and the error is explained in the ‘errorDescription’.
	public var ok: Bool {
		get { return json["ok"].boolValue }
		set { json["ok"].boolValue = newValue }
	}
		
    /// *Optional.* Error description.
	public var error_description: String? {
		get { return json["error_description"].string }
		set { json["error_description"].string = newValue }
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
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}
