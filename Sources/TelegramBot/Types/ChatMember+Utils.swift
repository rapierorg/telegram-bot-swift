//
// ChatMember+Utils.swift
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

	
