//
// MessageEntity+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

public enum MessageEntityType: String, Codable {
    case mention
    case hashtag
    case cashtag
    case botCommand = "bot_command"
    case url
    case email
    case phoneNumber = "phone_number"
    case bold
    case italic
    case underline
    case strikethrough
    case code
    case pre
    case textLink = "text_link"
    case textMention = "text_mention"
    case blockquote
  
    case unknown
  
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        self = MessageEntityType(rawValue: raw) ?? .unknown
    }
}
