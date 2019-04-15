// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// Represents the content of a venue message to be sent as the result of an inline query.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inputvenuemessagecontent>

public struct InputVenueMessageContent: JsonConvertible, InternalJsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
    internal var internalJson: JSON

    /// Latitude of the venue in degrees
    public var latitude: Float {
        get { return internalJson["latitude"].floatValue }
        set { internalJson["latitude"].floatValue = newValue }
    }

    /// Longitude of the venue in degrees
    public var longitude: Float {
        get { return internalJson["longitude"].floatValue }
        set { internalJson["longitude"].floatValue = newValue }
    }

    /// Name of the venue
    public var title: String {
        get { return internalJson["title"].stringValue }
        set { internalJson["title"].stringValue = newValue }
    }

    /// Address of the venue
    public var address: String {
        get { return internalJson["address"].stringValue }
        set { internalJson["address"].stringValue = newValue }
    }

    /// Optional. Foursquare identifier of the venue, if known
    public var foursquareId: String? {
        get { return internalJson["foursquare_id"].string }
        set { internalJson["foursquare_id"].string = newValue }
    }

    internal init(internalJson: JSON = [:]) {
        self.internalJson = internalJson
    }
    public init(json: Any) {
        self.internalJson = JSON(json)
    }
    public init(data: Data) {
        self.internalJson = JSON(data: data)
    }
}
