//
// NSScanner+Swift.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

extension NSScanner {
    func scanInt32() -> Int32? {
        var result: Int32 = 0
        return scanInt(&result) ? result : nil
    }
    
    func skipInt32() -> Bool {
        return scanInt(nil)
    }
    
    func scanInt() -> Int? {
        var result: Int = 0
        return scanInteger(&result) ? result : nil
    }
    
    func skipInt() -> Bool {
        return scanInteger(nil)
    }
    
    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanLongLong(&result) ? result : nil
    }
    
    func skipInt64() -> Bool {
        return scanLongLong(nil)
    }
    
    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }
    
    func skipUInt64() -> Bool {
        return scanUnsignedLongLong(nil)
    }
    
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return scanFloat(&result) ? result : nil
    }
    
    func skipFloat() -> Bool {
        return scanFloat(nil)
    }
    
    func scanDouble() -> Double? {
        var result: Double = 0.0
        return scanDouble(&result) ? result : nil
    }
    
    func skipDouble() -> Bool {
        return scanDouble(nil)
    }
    
    func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt(&result) ? result : nil
    }
    
    func skipHexUInt32() -> Bool {
        return scanHexInt(nil)
    }
    
    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexLongLong(&result) ? result : nil
    }
    
    func skipHexUInt64() -> Bool {
        return scanHexLongLong(nil)
    }
    
    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }
    
    func skipHexFloat() -> Bool {
        return scanHexFloat(nil)
    }
    
    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }
    
    func skipHexDouble() -> Bool {
        return scanHexDouble(nil)
    }
    
    func scanString(string: String) -> String? {
        var result: NSString? = nil
        if scanString(string, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func skipString(string: String) -> Bool {
        return scanString(string, intoString: nil)
    }
    
    func scanCharactersFromSet(set: NSCharacterSet) -> String? {
        var result: NSString? = nil
        if scanCharactersFromSet(set, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func skipCharactersFromSet(set: NSCharacterSet) -> Bool {
        return scanCharactersFromSet(set, intoString: nil)
    }
    
    func scanUpToString(string: String) -> String? {
        var result: NSString? = nil
        if scanUpToString(string, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func skipUpToString(string: String) -> Bool {
        return scanUpToString(string, intoString: nil)
    }
    
    func scanUpToCharactersFromSet(set: NSCharacterSet) -> String? {
        var result: NSString? = nil
        if scanUpToCharactersFromSet(set, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func skipUpToCharactersFromSet(set: NSCharacterSet) -> Bool {
        return scanUpToCharactersFromSet(set, intoString: nil)
    }
}
