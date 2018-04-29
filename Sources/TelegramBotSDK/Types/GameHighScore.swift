// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// This object represents one row of the high scores table for a game.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#gamehighscore>

public struct GameHighScore: JsonConvertible, InternalJsonConvertible {
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

    /// Position in high score table for the game
    public var position: Int {
        get { return internalJson["position"].intValue }
        set { internalJson["position"].intValue = newValue }
    }

    /// User
    public var user: User {
        get { return User(json: internalJson["user"]) }
        set { internalJson["user"] = JSON(newValue.json) }
    }

    /// Score
    public var score: Int {
        get { return internalJson["score"].intValue }
        set { internalJson["score"].intValue = newValue }
    }

    internal init(json: JSON = [:]) {
        self.internalJson = json
    }
    public init(jsonObject: Any) {
        self.internalJson = JSON(jsonObject)
    }
}
