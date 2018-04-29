// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// This object represent a user's profile pictures.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#userprofilephotos>

public struct UserProfilePhotos: JsonConvertible, InternalJsonConvertible {
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

    /// Total number of profile pictures the target user has
    public var totalCount: Int {
        get { return internalJson["total_count"].intValue }
        set { internalJson["total_count"].intValue = newValue }
    }

    /// Requested profile pictures (in up to 4 sizes each)
    public var photos: [[PhotoSize]] {
        get { return internalJson["photos"].twoDArrayValue() }
        set {
            var rowsJson = [JSON]()
            rowsJson.reserveCapacity(newValue.count)
            for row in newValue {
                var colsJson = [JSON]()
                colsJson.reserveCapacity(row.count)
                for col in row {
                    let json = col.internalJson
                    colsJson.append(json)
                }
                rowsJson.append(JSON(colsJson))
            }
            internalJson["photos"] = JSON(rowsJson)
        }
    }

    internal init(json: JSON = [:]) {
        self.internalJson = json
    }
    public init(jsonObject: Any) {
        self.internalJson = JSON(jsonObject)
    }
}
