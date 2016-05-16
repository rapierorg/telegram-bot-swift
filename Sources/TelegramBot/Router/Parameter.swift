// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public protocol Parameter {
    var shouldCaptureValue: Bool { get }
    var parameterName: String? { get }
    func fetchFrom(_ scanner: NSScanner) -> Any?
}
