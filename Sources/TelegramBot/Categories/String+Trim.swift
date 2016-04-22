//
// String+Trim.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension String {
    public func trim(set: NSCharacterSet = NSCharacterSet.whitespacesAndNewlines()) -> String {
        return trimmingCharacters(in: set)
    }
}
