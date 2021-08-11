import Foundation

extension Scanner {
    #if os(OSX)
    func scanInt() -> Int? {
        var result: Int = 0
        return scanInt(&result) ? result : nil
    }
    #endif

    #if os(OSX)
    func scanInt32() -> Int32? {
        var result: Int32 = 0
        return scanInt32(&result) ? result : nil
    }
    #endif

    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanInt64(&result) ? result : nil
    }

    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }
    
    #if os(OSX)
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return scanFloat(&result) ? result : nil
    }
    #endif
    
    #if os(OSX)
    func scanDouble() -> Double? {
        var result: Double = 0.0
        return scanDouble(&result) ? result : nil
    }
    #endif

    func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt32(&result) ? result : nil
    }

    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexInt64(&result) ? result : nil
    }

    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }

    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }

    #if os(OSX)
    func scanString(_ searchString: String) -> String? {
        var result: NSString?
        guard scanString(searchString, into: &result) else { return nil }
        return result as String?
    }
    #endif

    #if os(Linux) || os(Windows)
    func scanCharacters(from set: CharacterSet) -> String? {
        return scanCharactersFromSet(set)
    }
    #elseif os(OSX)
    func scanCharacters(from: CharacterSet) -> String? {
        var result: NSString?
        guard scanCharacters(from: from, into: &result) else { return nil }
        return result as String?
    }
    #endif

    #if os(Linux) || os(Windows)
    func scanUpTo(_ string: String) -> String? {
        if string.isEmpty {
            return scanUpToCharacters(from: CharacterSet())
        }
        return scanUpToString(string)
    }
    #elseif os(OSX)
    func scanUpTo(_ string: String) -> String? {
        var result: NSString?
        guard scanUpTo(string, into: &result) else { return nil }
        return result as String?
    }
    #endif

    #if os(Linux) || os(Windows)
    func scanUpToCharacters(from set: CharacterSet) -> String? {
        return scanUpToCharactersFromSet(set)
    }
    #elseif os(OSX)
    func scanUpToCharacters(from set: CharacterSet) -> String? {
        var result: NSString?
        guard scanUpToCharacters(from: set, into: &result) else { return nil }
        return result as String?
    }
    #endif
}


