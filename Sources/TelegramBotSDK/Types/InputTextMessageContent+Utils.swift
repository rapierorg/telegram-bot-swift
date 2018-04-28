//
// InputTextMessageContent+Utils.swift
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

extension InputTextMessageContent {
    /// Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    public var parseMode: TelegramBot.ParseMode? {
        get { return TelegramBot.ParseMode(rawValue:  internalJson["parse_mode"].string ?? "") }
        set { internalJson["parse_mode"].string = newValue?.rawValue }
    }
}
