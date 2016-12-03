//
// InlineQueryResult.swift
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
