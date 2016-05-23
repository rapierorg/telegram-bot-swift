// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

/// Represzents a message.
/// - SeeAlso: <https://core.telegram.org/bots/api#message>
public class Message: JsonObject {
	/// Original JSON for fields not yet added to Swift structures
	public var json: JSON

    /// Unique message identifier.
	public var message_id: Int {
		get { return json["message_id"].intValue }
		set { json["message_id"].intValue = newValue }
	}
		
    /// Sender.
	public var from: User {
		get { return User(json["from"]) }
		set { json["from"] = newValue.json }
	}
		
    /// Date the message was sent in Unix time.
	public var date: Int {
		get { return json["date"].intValue }
		set { json["date"].intValue = newValue }
	}
		
    /// Conversation the message belongs to.
	public var chat: Chat {
		get { return Chat(json["chat"]) }
		set { json["chat"] = newValue.json }
	}
		
    /// *Optional.* For forwarded messages, sender of the original message.
	public var forward_from: User? {
		get {
			let value = json["forward_from"]
			return value.isNullOrUnknown ? nil : User(value)
		}
		set {
			json["forward_from"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* For forwarded messages, date the original message was sent in Unix time.
	public var forward_date: Int? {
		get { return json["forward_date"].int }
		set {json["forward_date"].int = newValue }
	}
		
    /// *Optional.* For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
	public var reply_to_message: Message? {
		get {
			let value = json["reply_to_message"]
			return value.isNullOrUnknown ? nil : Message(value)
		}
		set {
			json["reply_to_message"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* For text messages, the actual UTF-8 text of the message.
	public var text: String? {
		get { return json["text"].string }
		set { json["text"].string = newValue }
	}
		
    /// *Optional.* Message is an audio file, information about the file.
	public var audio: Audio? {
		get {
			let value = json["audio"]
			return value.isNullOrUnknown ? nil : Audio(value)
		}
		set {
			json["audio"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* Message is a general file, information about the file.
	public var document: Document? {
		get {
			let value = json["document"]
			return value.isNullOrUnknown ? nil : Document(value)
		}
		set {
			json["document"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* Message is a photo, available sizes of the photo.
	public var photo: [PhotoSize] {
		get {
			var result = [PhotoSize]()
			guard let jsonPhoto = json["photo"].array else { return result }
			result.reserveCapacity(jsonPhoto.count)
			for jsonPhotoSize in jsonPhoto {
				result.append(PhotoSize(jsonPhotoSize))
			}
			return result
		}
		set {
			guard !newValue.isEmpty else {
				json["photo"] = nil
				return
			}
			var jsonPhoto = [JSON]()
			jsonPhoto.reserveCapacity(newValue.count)
			for photoSize in photo {
				jsonPhoto.append(photoSize.json)
			}
			json["photo"] = JSON(jsonPhoto)
		}
	}
	
    /// *Optional.* Message is a sticker, information about the sticker.
	public var sticker: Sticker? {
		get {
			let value = json["sticker"]
			return value.isNullOrUnknown ? nil : Sticker(value)
		}
		set {
			json["sticker"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* Message is a video, information about the video.
	public var video: Video? {
		get {
			let value = json["video"]
			return value.isNullOrUnknown ? nil : Video(value)
		}
		set {
			json["video"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* Message is a shared contact, information about the contact.
	public var contact: Contact? {
		get {
			let value = json["contact"]
			return value.isNullOrUnknown ? nil : Contact(value)
		}
		set {
			json["contact"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* Message is a shared location, information about the location.
	public var location: Location? {
		get {
			let value = json["location"]
			return value.isNullOrUnknown ? nil : Location(value)
		}
		set {
			json["location"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* A new member was added to the group, information about them (this member may be bot itself).
	public var new_chat_participant: User? {
		get {
			let value = json["new_chat_participant"]
			return value.isNullOrUnknown ? nil : User(value)
		}
		set {
			json["new_chat_participant"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* A member was removed from the group, information about them (this member may be bot itself).
	public var left_chat_participant: User? {
		get {
			let value = json["left_chat_participant"]
			return value.isNullOrUnknown ? nil : User(value)
		}
		set {
			json["left_chat_participant"] = newValue?.json ?? nil
		}
	}
		
    /// *Optional.* A group title was changed to this value.
	public var new_chat_title: String? {
		get { return json["new_chat_title"].string }
		set { json["new_chat_title"].string = newValue }
	}
		
    /// *Optional.* A group photo was changed to this value.
	public var new_chat_photo: [PhotoSize] {
		get {
			var result = [PhotoSize]()
			guard let jsonPhoto = json["new_chat_photo"].array else { return result }
			result.reserveCapacity(jsonPhoto.count)
			for jsonPhotoSize in jsonPhoto {
				result.append(PhotoSize(jsonPhotoSize))
			}
			return result
		}
		set {
			guard !newValue.isEmpty else {
				json["new_chat_photo"] = nil
				return
			}
			var jsonPhoto = [JSON]()
			jsonPhoto.reserveCapacity(newValue.count)
			for photoSize in photo {
				jsonPhoto.append(photoSize.json)
			}
			json["new_chat_photo"] = JSON(jsonPhoto)
		}
	}
		
    /// *Optional.* Informs that the group photo was deleted.
	public var delete_chat_photo: Bool {
		get { return json["delete_chat_photo"].boolValue }
		set { json["delete_chat_photo"].boolValue = newValue }
	}
		
    /// *Optional.* Informs that the group has been created.
	public var group_chat_created: Bool {
		get { return json["group_chat_created"].boolValue }
		set { json["group_chat_created"].boolValue = newValue }
	}
	
	public init(_ json: JSON = [:]) {
		self.json = json
	}
}
