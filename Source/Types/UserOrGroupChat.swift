//
// UserOrGroupChat.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public enum UserOrGroupChat {
    case UserType(User)
    case GroupChatType(GroupChat)
    
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

extension UserOrGroupChat: CustomDebugStringConvertible {
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
