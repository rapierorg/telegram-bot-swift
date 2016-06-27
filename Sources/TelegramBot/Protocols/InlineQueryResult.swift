// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public protocol InlineQueryResult: JsonConvertible {
}

extension InlineQueryResultCachedAudio: InlineQueryResult {
}

extension InlineQueryResultCachedDocument: InlineQueryResult {
}

extension InlineQueryResultCachedGif: InlineQueryResult {
}

extension InlineQueryResultCachedMpeg4Gif: InlineQueryResult {
}

extension InlineQueryResultCachedPhoto: InlineQueryResult {
}

extension InlineQueryResultCachedSticker: InlineQueryResult {
}

extension InlineQueryResultCachedVideo: InlineQueryResult {
}

extension InlineQueryResultCachedVoice: InlineQueryResult {
}

extension InlineQueryResultArticle: InlineQueryResult {
}

extension InlineQueryResultAudio: InlineQueryResult {
}

extension InlineQueryResultContact: InlineQueryResult {
}

extension InlineQueryResultDocument: InlineQueryResult {
}

extension InlineQueryResultGif: InlineQueryResult {
}

extension InlineQueryResultLocation: InlineQueryResult {
}

extension InlineQueryResultMpeg4Gif: InlineQueryResult {
}

extension InlineQueryResultPhoto: InlineQueryResult {
}

extension InlineQueryResultVenue: InlineQueryResult {
}

extension InlineQueryResultVideo: InlineQueryResult {
}

extension InlineQueryResultVoice: InlineQueryResult {
}
