//
// Message.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation
import SwiftyJSON

/// Represents a message.
public class Message {

    /// Unique message identifier.
    public var messageId: Int
    
    /// Sender.
    public var from: User
    
    /// Date the message was sent in Unix time.
    public var date: Int
    
    /// Conversation the message belongs to — user in case of a private message, GroupChat in case of a group.
    public var chat: UserOrGroupChat
    
    /// *Optional.* For forwarded messages, sender of the original message.
    public var forwardFrom: User?
    
    /// *Optional.* For forwarded messages, date the original message was sent in Unix time.
    public var forwardDate: Int?
    
    /// *Optional.* For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
    public var replyToMessage: Message?
    
    /// *Optional.* For text messages, the actual UTF-8 text of the message.
    public var text: String?
    
    /// *Optional.* Message is an audio file, information about the file.
    public var audio: Audio?
    
    /// *Optional.* Message is a general file, information about the file.
    public var document: Document?
    
    /// *Optional.* Message is a photo, available sizes of the photo.
    public var photo: [PhotoSize]
    
    /// *Optional.* Message is a sticker, information about the sticker.
    public var sticker: Sticker?
    
    /// *Optional.* Message is a video, information about the video.
    public var video: Video?
    
    /// *Optional.* Message is a shared contact, information about the contact.
    public var contact: Contact?
    
    /// *Optional.* Message is a shared location, information about the location.
    public var location: Location?
    
    /// *Optional.* A new member was added to the group, information about them (this member may be bot itself).
    public var newChatParticipant: User?
    
    /// *Optional.* A member was removed from the group, information about them (this member may be bot itself).
    public var leftChatParticipant: User?
    
    /// *Optional.* A group title was changed to this value.
    public var newChatTitle: String?
    
    /// *Optional.* A group photo was changed to this value.
    public var newChatPhoto: [PhotoSize]
    
    /// *Optional.* Informs that the group photo was deleted.
    public var deleteChatPhoto: Bool
    
    /// *Optional.* Informs that the group has been created.
    public var groupChatCreated: Bool
    
    /// Create an empty instance.
    public init() {
        messageId = 0
        from = User()
        date = 0
        chat = .UserType(User())
        photo = []
        newChatPhoto = []
        deleteChatPhoto = false
        groupChatCreated = false
    }
    
    /// Create an instance from JSON data.
    ///
    /// Will return nil if `json` is empty or invalid.
    public convenience init?(json: JSON) {
        self.init()
        
        if json.isNullOrUnknown { return nil }
        
        guard let messageId = json["message_id"].int else { return nil }
        self.messageId = messageId
        
        guard let from = User(json: json["from"]) else { return nil }
        self.from = from
        
        guard let date = json["date"].int else { return nil }
        self.date = date
        
        let jsonChat = json["chat"]
        if let user = User(json: jsonChat) {
            chat = .UserType(user)
        } else if let groupChat = GroupChat(json: jsonChat) {
            chat = .GroupChatType(groupChat)
        }
        
        forwardFrom = User(json: json["forward_from"])
        forwardDate = json["forward_date"].int
        replyToMessage = Message(json: json["reply_to_message"])
        text = json["text"].string
        audio = Audio(json: json["audio"])
        document = Document(json: json["document"])
        
        let photo = json["photo"].arrayValue
        self.photo = [PhotoSize]()
        self.photo.reserveCapacity(photo.count)
        for jsonPhotoSize in photo {
            guard let photoSize = PhotoSize(json: jsonPhotoSize) else { return nil }
            self.photo.append(photoSize)
        }
        
        sticker = Sticker(json: json["sticker"])
        video = Video(json: json["video"])
        contact = Contact(json: json["contact"])
        location = Location(json: json["location"])
        newChatParticipant = User(json: json["new_chat_participant"])
        leftChatParticipant = User(json: json["left_chat_participant"])
        newChatTitle = json["new_chat_title"].string
        
        let newChatPhoto = json["new_chat_photo"].arrayValue
        self.newChatPhoto = [PhotoSize]()
        self.newChatPhoto.reserveCapacity(newChatPhoto.count)
        for jsonPhotoSize in newChatPhoto {
            guard let photoSize = PhotoSize(json: jsonPhotoSize) else { return nil }
            self.newChatPhoto.append(photoSize)
        }
        
        deleteChatPhoto = json["delete_chat_photo"].boolValue
        groupChatCreated = json["group_chat_created"].boolValue
    }
    
    public var prettyPrint: String {
        var result = "Message(\n"
        result += "  messageId: \(messageId)\n"
        result += "  from: \(from.prettyPrint.indent().trim())\n"
        result += "  date: \(date)\n"
        result += "  chat: \(chat.prettyPrint.indent().trim())\n"
        if let forwardFrom = forwardFrom {
            result += "  forwardFrom: \(forwardFrom.prettyPrint.indent().trim())\n"
        }
        if let forwardDate = forwardDate {
            result += "  forwardDate: \(forwardDate)\n"
        }
        if let replyToMessage = replyToMessage {
            result += "  replyToMessage: \(replyToMessage.prettyPrint.indent().trim())\n"
        }
        if let text = text {
            result += "  text: \(text)\n"
        }
        if let audio = audio {
            result += "  audio: \(audio.prettyPrint.indent().trim())\n"
        }
        if let document = document {
            result += "  document: \(document.prettyPrint.indent().trim())\n"
        }
        result += "  photo: \(photo)\n"
        if let sticker = sticker {
            result += "  sticker: \(sticker.prettyPrint.indent().trim())\n"
        }
        if let video = video {
            result += "  video: \(video.prettyPrint.indent().trim())\n"
        }
        if let contact = contact {
            result += "  contact: \(contact.prettyPrint.indent().trim())\n"
        }
        if let location = location {
            result += "  location: \(location.prettyPrint.indent().trim())\n"
        }
        if let newChatParticipant = newChatParticipant {
            result += "  newChatParticipant: \(newChatParticipant.prettyPrint.indent().trim())\n"
        }
        if let leftChatParticipant = leftChatParticipant {
            result += "  leftChatParticipant: \(leftChatParticipant.prettyPrint.indent().trim())\n"
        }
        if let newChatTitle = newChatTitle {
            result += "  newChatTitle: \(newChatTitle)\n"
        }
        result += "  deleteChatPhoto: \(deleteChatPhoto)\n"
        result += ")"
        return result
    }
}

extension Message: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Message(messageId: \(messageId), from: \(from), date: \(date), chat: \(chat), " +
            "forwardFrom: \(forwardFrom.unwrapAndPrint), forwardDate: \(forwardDate.unwrapAndPrint), " +
            "replyToMessage: \(replyToMessage.unwrapAndPrint), text: \(text.unwrapAndPrint), " +
            "audio: \(audio.unwrapAndPrint), document: \(document.unwrapAndPrint), photo: \(photo), " +
            "sticker: \(sticker.unwrapAndPrint), video: \(video.unwrapAndPrint), " +
            "contact: \(contact.unwrapAndPrint), location: \(location.unwrapAndPrint), " +
            "newChatParticipant: \(newChatParticipant.unwrapAndPrint), " +
            "leftChatParticipant: \(leftChatParticipant.unwrapAndPrint), " +
            "newChatTitle: \(newChatTitle.unwrapAndPrint), newChatPhoto: \(newChatPhoto), " +
            "deleteChatPhoto: \(deleteChatPhoto), groupChatCreated: \(groupChatCreated))"
    }
}
