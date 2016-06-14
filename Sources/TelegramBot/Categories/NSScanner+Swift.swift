// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension Scanner {
    func scanInt32() -> Int32? {
        var result: Int32 = 0
        return scanInt32(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt32() -> Bool {
        return scanInt32(nil)
    }
    
    func scanInt() -> Int? {
        var result: Int = 0
        return scanInt(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt() -> Bool {
        return scanInt(nil)
    }
    
    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanInt64(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt64() -> Bool {
        return scanInt64(nil)
    }
    
    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }
    
	@discardableResult
    func skipUInt64() -> Bool {
        return scanUnsignedLongLong(nil)
    }
    
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return scanFloat(&result) ? result : nil
    }
    
	@discardableResult
    func skipFloat() -> Bool {
        return scanFloat(nil)
    }
    
    func scanDouble() -> Double? {
        var result: Double = 0.0
        return scanDouble(&result) ? result : nil
    }
    
	@discardableResult
    func skipDouble() -> Bool {
        return scanDouble(nil)
    }
    
    func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt32(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexUInt32() -> Bool {
        return scanHexInt32(nil)
    }
    
    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexInt64(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexUInt64() -> Bool {
        return scanHexInt64(nil)
    }
    
    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexFloat() -> Bool {
        return scanHexFloat(nil)
    }
    
    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexDouble() -> Bool {
        return scanHexDouble(nil)
    }
    
	@discardableResult
    func skipString(_ string: String) -> Bool {
        return scanString(string, into: nil)
    }
    
    func scanCharactersFromSet(_ set: CharacterSet) -> String? {
        var result: NSString? = nil
		if scanCharacters(from: set, into: &result) {
            return result as? String
        }
        return nil
    }
	
	@discardableResult
    func skipCharactersFromSet(_ set: CharacterSet) -> Bool {
		return scanCharacters(from: set, into: nil)
    }
    
    func scanUpToString(_ string: String) -> String? {
        var result: NSString? = nil
		if scanUpTo(string, into: &result) {
            return result as? String
        }
        return nil
    }
	
	@discardableResult
    func skipUpToString(_ string: String) -> Bool {
        return scanUpTo(string, into: nil)
    }
    
    func scanUpToCharactersFromSet(_ set: CharacterSet) -> String? {
        var result: NSString? = nil
		if scanUpToCharacters(from: set, into: &result) {
            return result as? String
        }
        return nil
    }
    
	@discardableResult
    func skipUpToCharactersFromSet(_ set: CharacterSet) -> Bool {
		return scanUpToCharacters(from: set, into: nil)
    }
}
