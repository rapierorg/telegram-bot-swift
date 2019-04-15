//
// ContentType.swift
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

public enum ContentType {
	case command(Command)
    case commands([Command])
	case from
	case forwardFrom
	case forwardFromChat
	case forwardDate
	case replyToMessage
	case editDate
	case text
	case entities
	case audio
	case document
	case photo
	case sticker
	case video
	case voice
	case caption
	case contact
	case location
	case venue
	case newChatMembers
	case leftChatMember
	case newChatTitle
	case newChatPhoto
	case deleteChatPhoto
	case groupChatCreated
	case supergroupChatCreated
	case channelChatCreated
	case migrateToChatId
	case migrateFromChatId
	case pinnedMessage
    case callback_query(data: String?)
}
