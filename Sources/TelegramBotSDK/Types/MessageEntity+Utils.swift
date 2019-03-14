//
// MessageEntity+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

extension MessageEntity {
    // Type name is a reserved Swift word
    public enum MessageEntityType: String {
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
    public var type: MessageEntityType? {
        get { return MessageEntityType(rawValue: internalJson["type"].string ?? "") }
        set { internalJson["type"].string = newValue?.rawValue }
    }
}
