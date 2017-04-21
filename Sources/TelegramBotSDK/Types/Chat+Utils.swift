//
// Chat+Utils.swift
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

