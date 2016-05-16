//
// UserOrGroupChat.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public enum UserOrGroupChat {
    case UserType(User)
    case GroupChatType(GroupChat)
    
    /// Unique identifier for this user or group chat.
    public var id: Int {
        switch self {
        case let .UserType(user): return user.id
        case let .GroupChatType(groupChat): return groupChat.id
        }
    }
}

