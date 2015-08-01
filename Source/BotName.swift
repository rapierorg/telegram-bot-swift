//
// BotName.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class BotName {
    let underscoreBotSuffix = "_bot"
    let botSuffix = "bot"
    public var withoutSuffix: String

    public init(username: String) {
        let lowercase = username.lowercaseString
        if lowercase.hasSuffix(underscoreBotSuffix) {
            withoutSuffix = username.substringToIndex(
                advance(username.endIndex,
                    -underscoreBotSuffix.characters.count))
            
        } else if lowercase.hasSuffix(botSuffix) {
            withoutSuffix = username.substringToIndex(
                advance(username.endIndex,
                    -botSuffix.characters.count))
            
        } else {
            withoutSuffix = username
        }
    }


}

extension BotName: Equatable {
}

public func ==(lhs: BotName, rhs: BotName) -> Bool {
    return lhs.withoutSuffix == rhs.withoutSuffix
}

extension BotName: Comparable {
}

public func <(lhs: BotName, rhs: BotName) -> Bool {
    return lhs.withoutSuffix < rhs.withoutSuffix
}
