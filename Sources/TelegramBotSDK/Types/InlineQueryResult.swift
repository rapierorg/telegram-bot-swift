//
// InlineQueryResult.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

public enum InlineQueryResult: Codable {
    case cachedAudio(InlineQueryResultCachedAudio)
    case cachedDocument(InlineQueryResultCachedDocument)
    case cachedGif(InlineQueryResultCachedGif)
    case cachedMpeg4Gif(InlineQueryResultCachedMpeg4Gif)
    case cachedPhoto(InlineQueryResultCachedPhoto)
    case cachedSticker(InlineQueryResultCachedSticker)
    case cachedVideo(InlineQueryResultCachedVideo)
    case cachedVoice(InlineQueryResultCachedVoice)
    case article(InlineQueryResultArticle)
    case audio(InlineQueryResultAudio)
    case contact(InlineQueryResultContact)
    case document(InlineQueryResultDocument)
    case gif(InlineQueryResultGif)
    case location(InlineQueryResultLocation)
    case mpeg4Gif(InlineQueryResultMpeg4Gif)
    case photo(InlineQueryResultPhoto)
    case venue(InlineQueryResultVenue)
    case video(InlineQueryResultVideo)
    case voice(InlineQueryResultVoice)
    case unknown
    
    public init(from decoder: Decoder) throws {
        if let cachedAudio = try? decoder.singleValueContainer().decode(InlineQueryResultCachedAudio.self) {
            self = .cachedAudio(cachedAudio)
            return
        }
        if let cachedDocument = try? decoder.singleValueContainer().decode(InlineQueryResultCachedDocument.self) {
            self = .cachedDocument(cachedDocument)
            return
        }
        if let cachedGif = try? decoder.singleValueContainer().decode(InlineQueryResultCachedGif.self) {
            self = .cachedGif(cachedGif)
            return
        }
        if let cachedMpeg4Gif = try? decoder.singleValueContainer().decode(InlineQueryResultCachedMpeg4Gif.self) {
            self = .cachedMpeg4Gif(cachedMpeg4Gif)
            return
        }
        if let cachedPhoto = try? decoder.singleValueContainer().decode(InlineQueryResultCachedPhoto.self) {
            self = .cachedPhoto(cachedPhoto)
            return
        }
        
        if let cachedSticker = try? decoder.singleValueContainer().decode(InlineQueryResultCachedSticker.self) {
            self = .cachedSticker(cachedSticker)
            return
        }
        
        if let cachedVideo = try? decoder.singleValueContainer().decode(InlineQueryResultCachedVideo.self) {
            self = .cachedVideo(cachedVideo)
            return
        }
        
        if let cachedVoice = try? decoder.singleValueContainer().decode(InlineQueryResultCachedVoice.self) {
            self = .cachedVoice(cachedVoice)
            return
        }
        
        if let article = try? decoder.singleValueContainer().decode(InlineQueryResultArticle.self) {
            self = .article(article)
            return
        }
        
        if let audio = try? decoder.singleValueContainer().decode(InlineQueryResultAudio.self) {
            self = .audio(audio)
            return
        }
        
        if let contact = try? decoder.singleValueContainer().decode(InlineQueryResultContact.self) {
            self = .contact(contact)
            return
        }
        
        if let document = try? decoder.singleValueContainer().decode(InlineQueryResultDocument.self) {
            self = .document(document)
            return
        }
        
        if let gif = try? decoder.singleValueContainer().decode(InlineQueryResultGif.self) {
            self = .gif(gif)
            return
        }
        
        if let location = try? decoder.singleValueContainer().decode(InlineQueryResultLocation.self) {
            self = .location(location)
            return
        }
        
        if let mpeg4Gif = try? decoder.singleValueContainer().decode(InlineQueryResultMpeg4Gif.self) {
            self = .mpeg4Gif(mpeg4Gif)
            return
        }
        
        if let photo = try? decoder.singleValueContainer().decode(InlineQueryResultPhoto.self) {
            self = .photo(photo)
            return
        }
        
        if let venue = try? decoder.singleValueContainer().decode(InlineQueryResultVenue.self) {
            self = .venue(venue)
            return
        }
        
        if let video = try? decoder.singleValueContainer().decode(InlineQueryResultVideo.self) {
            self = .video(video)
            return
        }
        
        if let voice = try? decoder.singleValueContainer().decode(InlineQueryResultVoice.self) {
            self = .voice(voice)
            return
        }
        
        self = .unknown
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .cachedAudio(cachedAudio):
            try container.encode(cachedAudio)
        case let .cachedDocument(cachedDocument):
            try container.encode(cachedDocument)
        case let .cachedGif(cachedGif):
            try container.encode(cachedGif)
        case let .cachedMpeg4Gif(cachedMpeg4Gif):
            try container.encode(cachedMpeg4Gif)
        case let .cachedPhoto(cachedPhoto):
            try container.encode(cachedPhoto)
        case let .cachedSticker(cachedSticker):
            try container.encode(cachedSticker)
        case let .cachedVideo(cachedVideo):
            try container.encode(cachedVideo)
        case let .cachedVoice(cachedVoice):
            try container.encode(cachedVoice)
        case let .article(article):
            try container.encode(article)
        case let .audio(audio):
            try container.encode(audio)
        case let .contact(contact):
            try container.encode(contact)
        case let .document(document):
            try container.encode(document)
        case let .gif(gif):
            try container.encode(gif)
        case let .location(location):
            try container.encode(location)
        case let .mpeg4Gif(mpeg4Gif):
            try container.encode(mpeg4Gif)
        case let .photo(photo):
            try container.encode(photo)
        case let .venue(venue):
            try container.encode(venue)
        case let .video(video):
            try container.encode(video)
        case let .voice(voice):
            try container.encode(voice)
        default:
            fatalError("Unknown should not be used")
        }
    }
}
