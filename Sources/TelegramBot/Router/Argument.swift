// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public struct Argument {
    public let value: Any?

    public var stringValue: String {
        guard let v = value as? String else { fatalError() }
        return v
    }

    public var stringArrayValue: [String] {
        guard let v = value as? [String] else { fatalError() }
        return v
    }
    
    public var intValue: Int {
        guard let v = value as? Int else { fatalError() }
        return v
    }
    
    public var intArrayValue: [Int] {
        guard let v = value as? [Int] else { fatalError() }
        return v
    }

    public var doubleValue: Double {
        guard let v = value as? Double else { fatalError() }
        return v
    }
    
    public var doubleArrayValue: [Double] {
        guard let v = value as? [Double] else { fatalError() }
        return v
    }
    
    init(value: Any?) {
        self.value = value
    }
}
