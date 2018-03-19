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
	case forward_from
	case forward_from_chat
	case forward_date
	case reply_to_message
	case edit_date
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
	case new_chat_members
	case left_chat_member
	case new_chat_title
	case new_chat_photo
	case delete_chat_photo
	case group_chat_created
	case supergroup_chat_created
	case channel_chat_created
	case migrate_to_chat_id
	case migrate_from_chat_id
	case pinned_message
    case callback_query(data: String?)
}
