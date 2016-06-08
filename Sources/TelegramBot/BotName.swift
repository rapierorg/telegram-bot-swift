// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class BotName {
    let underscoreBotSuffix = "_bot"
    let botSuffix = "bot"
    public var withoutSuffix: String

    public init(username: String) {
        let lowercase = username.lowercased()
        if lowercase.hasSuffix(underscoreBotSuffix) {
			withoutSuffix = username.substring(to:
				username.index(username.endIndex, offsetBy:
                    -underscoreBotSuffix.characters.count))
            
        } else if lowercase.hasSuffix(botSuffix) {
			withoutSuffix = username.substring(to:
				username.index(username.endIndex, offsetBy:
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
