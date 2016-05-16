//
// Location.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a point on the map.
public class Location: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON
	
    /// Longitude as defined by sender.
    public var longitude: Float
    
    /// Latitude as defined by sender.
    public var latitude: Float
    
    /// Create an empty instance.
    public init() {
		self.json = nil
        longitude = 0.0
        latitude = 0.0
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(_ json: JSON) {
        self.init()
		self.json = json

        if json.isNullOrUnknown { return nil }
        
        guard let longitude = json["longitude"].float else { return nil }
        self.longitude = longitude
        
        guard let latitude = json["latitude"].float else { return nil }
        self.latitude = latitude
    }
    
    public var prettyPrint: String {
        return "Location(" +
            "  longitude: \(longitude)\n" +
            "  latitude: \(latitude)\n" +
        ")"
    }
}

extension Location: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Location(longitude: \(longitude), latitude: \(latitude))"
    }
}

