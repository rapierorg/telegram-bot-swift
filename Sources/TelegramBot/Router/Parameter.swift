//
// Parameter.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public protocol /*NS*/Parameter {
    var shouldCaptureValue: Bool { get }
    var parameterName: String? { get }
    func fetchFrom(scanner: NSScanner) -> Any?
}
