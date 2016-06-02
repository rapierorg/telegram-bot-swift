// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a phone contact.
/// - SeeAlso: <https://core.telegram.org/bots/api#contact>
public class Contact: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Contact's phone number.
	public var phone_number: String {
		get { return json["phone_number"].stringValue }
		set { json["phone_number"].stringValue = newValue }
	}
		
    /// Contact's first name.
	public var first_name: String {
		get { return json["first_name"].stringValue }
		set { json["first_name"].stringValue = newValue }
	}
		
    /// *Optional.* Contact's last name.
	public var last_name: String? {
		get { return json["last_name"].string }
		set { json["last_name"].string = newValue }
	}
		
    /// *Optional.* Contact's user identifier in Telegram.
    public var user_id: String? {
		get { return json["user_id"].string }
		set { json["user_id"].string = newValue }
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
    }
}
