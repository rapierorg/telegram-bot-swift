// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public enum ReplyMarkup {
    case ReplyKeyboardMarkupType(ReplyKeyboardMarkup)
    case ReplyKeyboardHideType(ReplyKeyboardHide)
    case ForceReplyType(ForceReply)
    
    public var prettyPrint: String {
        return debugDescription
    }
}

extension ReplyMarkup: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .ReplyKeyboardMarkupType(v):
            return v.description
        case let .ReplyKeyboardHideType(v):
            return v.description
        case let .ForceReplyType(v):
            return v.description
        }        
    }
}

extension ReplyMarkup: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        var s = "ReplyMarkup("
        switch self {
        case let .ReplyKeyboardMarkupType(v):
            s += "replyKeyboardMarkup: \(v)"
        case let .ReplyKeyboardHideType(v):
            s += "replyKeyboardHide: \(v)"
        case let .ForceReplyType(v):
            s += "forceReply: \(v)"
        }
        s += ")"
        return s
    }
}
