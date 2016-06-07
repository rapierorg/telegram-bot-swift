// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public enum ContentType {
	case command(Command)
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
	case new_chat_member
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
}
