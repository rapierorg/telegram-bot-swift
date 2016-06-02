// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represents a video file.
/// - SeeAlso: <https://core.telegram.org/bots/api#video>
public class Video: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Unique identifier for this file.
	public var file_id: String {
		get { return json["file_id"].stringValue }
		set { json["file_id"].stringValue = newValue }
	}
		
    /// Video width as defined by sender.
	public var width: Int {
		get { return json["width"].intValue }
		set { json["width"].intValue = newValue }
	}
		
    /// Video height as defined by sender.
	public var height: Int {
		get { return json["height"].intValue }
		set { json["height"].intValue = newValue }
	}
	
    /// Duration of the video in seconds as defined by sender.
	public var duration: Int {
		get { return json["duration"].intValue }
		set { json["duration"].intValue = newValue }
	}
    /// Video thumbnail.
	public var thumb: PhotoSize {
		get { return PhotoSize(json: json["thumb"]) }
		set { json["thumb"] = newValue.json }
	}
	
    /// *Optional.* Mime type of a file as defined by sender.
	public var mime_type: String? {
		get { return json["mime_type"].string }
		set { json["mime_type"].string = newValue }
	}
	
    /// *Optional.* File size.
	public var file_size: Int? {
		get { return json["file_size"].int }
		set { json["file_size"].int = newValue }
	}
	
    /// *Optional.* Text description of the video (usually empty).
	public var caption: String? {
		get { return json["caption"].string }
		set { json["caption"].string = newValue }
	}
	
	public required init(json: JSON = [:]) {
		self.json = json
	}
}

