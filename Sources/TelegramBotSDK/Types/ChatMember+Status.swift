//
// ChatMember+Utils.swift
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

extension ChatMember {
	public enum Status: String, Codable {
		case creator
		case administrator
		case member
        case restricted
		case left
		case kicked
	}
}

	
