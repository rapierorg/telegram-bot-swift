// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public enum ContentType {
	case command(Command)
	case audio
	case document
	case photo
	case sticker
	case video
	case voice
	case contact
	case location
	case venue
	case newChatMember
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
}
