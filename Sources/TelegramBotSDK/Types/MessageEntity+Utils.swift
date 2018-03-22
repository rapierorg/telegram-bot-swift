//
//  MessageEntity+Utils.swift
//  TelegramBotSDKPackageDescription
//
//  Created by Matteo Piccina on 22/03/18.
//

import Foundation

extension MessageEntity {
    // Type name is a reserved Swift word
    public enum METype: String {
        case mention
        case hashtag
        case botCommand = "bot_command"
        case url
        case email
        case bold
        case italic
        case code
        case pre
        case textLink = "text_link"
        case textMention = "text_mention"
    }
    
    /// Type of the entity. Can be mention (@username), hashtag, bot_command, url, email, bold (bold text), italic (italic text), code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
    public var type: METype {
        get { return METype(rawValue:  json["type"].string ?? "") }
        set { json["type"].string = newValue?.rawValue }
    }
}
