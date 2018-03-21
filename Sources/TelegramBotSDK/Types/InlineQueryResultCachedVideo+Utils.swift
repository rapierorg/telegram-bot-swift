//
//  InlineQueryResultCachedVideo+Utils.swift
//  TelegramBotSDK
//
//  Created by Matteo Piccina on 21/03/18.
//

import Foundation

extension InlineQueryResultCachedVideo {
    /// Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    public var parseMode: TelegramBot.ParseMode? {
        get { return TelegramBot.ParseMode(rawValue:  json["parse_mode"].string ?? "") }
        set { json["parse_mode"].string = newValue?.rawValue }
    }
}
