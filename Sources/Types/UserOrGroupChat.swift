//
// UserOrGroupChat.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public enum /*NS*/UserOrGroupChat {
    case UserType(/*NS*/User)
    case GroupChatType(/*NS*/GroupChat)
    
    /// Unique identifier for this user or group chat.
    public var id: Int {
        switch self {
        case let .UserType(user): return user.id
        case let .GroupChatType(groupChat): return groupChat.id
        }
    }
    
    public var prettyPrint: String {
        var s = "UserOrGroupChat(\n"
        switch self {
        case let .UserType(user): s += "  user: \(user.prettyPrint.indent().trim())\n"
        case let .GroupChatType(groupChat): s += "  groupChat: \(groupChat.prettyPrint.indent().trim())\n"
        }
        s += ")"
        return s
        
    }
}

extension /*NS*/UserOrGroupChat: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        var s = "UserOrGroupChat("
        switch self {
        case let .UserType(user): s += "user: \(user)"
        case let .GroupChatType(groupChat): s += "groupChat: \(groupChat)"
        }
        s += ")"
        return s
    }
}
