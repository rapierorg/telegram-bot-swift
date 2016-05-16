//
// Contact.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a phone contact.
public class Contact: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Contact's phone number.
    public var phoneNumber: String
    
    /// Contact's first name.
    public var firstName: String
    
    /// *Optional.* Contact's last name.
    public var lastName: String?
    
    /// *Optional.* Contact's user identifier in Telegram.
    public var userId: String?
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        phoneNumber = ""
        firstName = ""
    }
    
    public convenience init?(_ json: JSON) {
        self.init()
		self.json = json

        if json.isNullOrUnknown { return nil }
        
        guard let phoneNumber = json["phone_number"].string else { return nil }
        self.phoneNumber = phoneNumber
        
        guard let firstName = json["first_name"].string else { return nil }
        self.firstName = firstName
        
        lastName = json["last_name"].string
        userId = json["user_id"].string
    }
    
    public var prettyPrint: String {
        var result = "Contact(" +
            "  phoneNumber: \(phoneNumber)" +
            "  firstName: \(firstName)"
        if let lastName = lastName {
            result += "  lastName: \(lastName)"
        }
        if let userId = userId {
            result += "  userId: \(userId)"
        }
        result += ")"
        return result
    }
}

extension Contact: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Contact(phoneNumber: \(phoneNumber), firstName: \(firstName), " +
            "lastName: \(lastName.unwrapOptional), userId: \(userId.unwrapOptional))"
    }
}

