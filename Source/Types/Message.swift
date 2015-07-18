//
// Message.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
        chat = .User(User())
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
            chat = .User(user)
        } else if let groupChat = GroupChat(json: jsonChat) {
            chat = .GroupChat(groupChat)
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
}

extension Message: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        return "Message(messageId: \(messageId), from: \(from), date: \(date), chat: \(chat), " +
            "forwardFrom: \(forwardFrom), forwardDate: \(forwardDate), replyToMessage: \(replyToMessage), " +
            "text: \(text), audio: \(audio), document: \(document), photo: \(photo), sticker: \(sticker)" +
            "video: \(video), contact: \(contact), location: \(location), " +
            "newChatParticipant: \(newChatParticipant), leftChatParticipant: \(leftChatParticipant), " +
            "newChatTitle: \(newChatTitle), newChatPhoto: \(newChatPhoto), " +
            "deleteChatPhoto: \(deleteChatPhoto), groupChatCreated: \(groupChatCreated))"
    }
}
