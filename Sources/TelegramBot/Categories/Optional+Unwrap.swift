//
// Optional+Unwrap.swift
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

extension Optional {
    /// Removes `Optional()` when printing optionals.
    /// ```swift
    /// var x: String? = "text"
    /// var y: String?
    /// print("\(x), \(y)")
    /// print("\(x.unwrapOptional), \(y.unwrapOptional")
    /// ```
    /// Results in:
    /// ```
    /// Optional("text"), nil
    /// text, nil
    /// ```
    public var unwrapOptional: String {
        if let v = self {
            return "\(v)"
        }
        return "nil"
    }
}
