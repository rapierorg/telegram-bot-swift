//
// Argument.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public struct Argument {
    public let value: Any?

    var stringValue: String {
        guard let v = value as? String else { fatalError() }
        return v
    }

    var stringArrayValue: [String] {
        guard let v = value as? [String] else { fatalError() }
        return v
    }

    init(value: Any?) {
        self.value = value
    }
}