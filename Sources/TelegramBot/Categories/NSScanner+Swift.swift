// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension Scanner {
    func scanInt32() -> Int32? {
        var result: Int32 = 0
        return self.scanInt32(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt32() -> Bool {
        return self.scanInt32(nil)
    }
    
    func scanInt() -> Int? {
        var result: Int = 0
        return self.scanInt(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt() -> Bool {
        return self.scanInt(nil)
    }
    
    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return self.scanInt64(&result) ? result : nil
    }
    
	@discardableResult
    func skipInt64() -> Bool {
        return self.scanInt64(nil)
    }
    
    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return self.scanUnsignedLongLong(&result) ? result : nil
    }
    
	@discardableResult
    func skipUInt64() -> Bool {
        return self.scanUnsignedLongLong(nil)
    }
    
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return self.scanFloat(&result) ? result : nil
    }
    
	@discardableResult
    func skipFloat() -> Bool {
        return self.scanFloat(nil)
    }
    
    func scanDouble() -> Double? {
        var result: Double = 0.0
        return self.scanDouble(&result) ? result : nil
    }
    
	@discardableResult
    func skipDouble() -> Bool {
        return self.scanDouble(nil)
    }
    
    func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return self.scanHexInt32(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexUInt32() -> Bool {
        return self.scanHexInt32(nil)
    }
    
    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return self.scanHexInt64(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexUInt64() -> Bool {
        return self.scanHexInt64(nil)
    }
    
    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return self.scanHexFloat(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexFloat() -> Bool {
        return self.scanHexFloat(nil)
    }
    
    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return self.scanHexDouble(&result) ? result : nil
    }
    
	@discardableResult
    func skipHexDouble() -> Bool {
        return self.scanHexDouble(nil)
    }
    
	@discardableResult
    func skipString(_ string: String) -> Bool {
        return self.scanString(string, into: nil)
    }
    
    func scanCharactersFromSet(_ set: CharacterSet) -> String? {
        var result: NSString? = nil
		if self.scanCharacters(from: set, into: &result) {
            return result as? String
        }
        return nil
    }
	
	@discardableResult
    func skipCharactersFromSet(_ set: CharacterSet) -> Bool {
		return self.scanCharacters(from: set, into: nil)
    }
    
    func scanUpToString(_ string: String) -> String? {
        var result: NSString? = nil
		if self.scanUpTo(string, into: &result) {
            return result as? String
        }
        return nil
    }
	
	@discardableResult
    func skipUpToString(_ string: String) -> Bool {
        return self.scanUpTo(string, into: nil)
    }
    
    func scanUpToCharactersFromSet(_ set: CharacterSet) -> String? {
        var result: NSString? = nil
		if self.scanUpToCharacters(from: set, into: &result) {
            return result as? String
        }
        return nil
    }
    
	@discardableResult
    func skipUpToCharactersFromSet(_ set: CharacterSet) -> Bool {
		return self.scanUpToCharacters(from: set, into: nil)
    }
}
