// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation
import SwiftyJSON

extension ChatMember {
	public enum Status: String {
		case creator = "creator"
		case administrator = "administrator"
		case member = "member"
		case left = "left"
		case kicked = "kicked"
		case unknown = ""
	}
	
	/// The member's status in the chat. Can be “creator”, “administrator”, “member”, “left” or “kicked”.
	public var status: Status {
		get { return Status(rawValue: status_string) ?? .unknown }
		set { status_string = newValue.rawValue }
	}
}

	
