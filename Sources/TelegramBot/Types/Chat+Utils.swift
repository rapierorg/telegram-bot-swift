// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

extension Chat {
	public enum ChatType: String {
		case private_chat = "private"
		case group = "group"
		case supergroup = "supergroup"
		case channel = "channel"
		case unknown = ""
	}
	
	/// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	public var type: ChatType {
		get { return ChatType(rawValue: type_string) ?? .unknown }
		set { type_string = newValue.rawValue }
	}
}

