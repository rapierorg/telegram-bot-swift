//
// BotName.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/BotName {
    let underscoreBotSuffix = "_bot"
    let botSuffix = "bot"
    public var withoutSuffix: String

    public init(username: String) {
        let lowercase = username.lowercased()
        if lowercase.hasSuffix(underscoreBotSuffix) {
			withoutSuffix = username.substring(to:
				username.endIndex.advanced(by:
                    -underscoreBotSuffix.characters.count))
            
        } else if lowercase.hasSuffix(botSuffix) {
			withoutSuffix = username.substring(to:
				username.endIndex.advanced(by:
                    -botSuffix.characters.count))
            
        } else {
            withoutSuffix = username
        }
    }


}

extension /*NS*/BotName: Equatable {
}

public func ==(lhs: /*NS*/BotName, rhs: /*NS*/BotName) -> Bool {
    return lhs.withoutSuffix == rhs.withoutSuffix
}

extension /*NS*/BotName: Comparable {
}

public func <(lhs: /*NS*/BotName, rhs: /*NS*/BotName) -> Bool {
    return lhs.withoutSuffix < rhs.withoutSuffix
}
