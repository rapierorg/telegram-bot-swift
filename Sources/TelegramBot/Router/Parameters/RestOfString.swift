// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class RestOfString: Parameter {
    
    public init(_ parameterName: String? = nil, capture: Bool = true) {
        self.parameterName = parameterName
        self.shouldCaptureValue = capture
    }
    
    public let shouldCaptureValue: Bool
    public var parameterName: String?
    
    public func fetchFrom(_ scanner: NSScanner) -> Any? {
        guard let restOfString = scanner.scanUpToString("") else {
            return nil
        }
        return restOfString
    }
}
