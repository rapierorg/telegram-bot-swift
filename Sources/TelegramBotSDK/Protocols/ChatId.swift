//
// ChatId.swift
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

public enum ChatId: Codable {
    case string(String)
    case int64(Int64)
    case unknown
    
    public init(from decoder: Decoder) throws {
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        if let int64 = try? decoder.singleValueContainer().decode(Int64.self) {
            self = .int64(int64)
            return
        }
        
        self = .unknown
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .string(string):
            try container.encode(string)
        case let .int64(int64):
            try container.encode(int64)
        default:
            fatalError("Unknown should not be used")
        }
    }
}
