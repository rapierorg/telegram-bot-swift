//
// NSScanner+Swift.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension NSScanner {
    func scanInt32() -> Int32? {
        var result: Int32 = 0
        return scanInt(&result) ? result : nil
    }
    
    func scanInt() -> Int? {
        var result: Int = 0
        return scanInteger(&result) ? result : nil
    }
    
    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanLongLong(&result) ? result : nil
    }
    
    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }
    
    func scanFloat() -> Float? {
        var result: Float = 0.0
        return scanFloat(&result) ? result : nil
    }
    
    func scanDouble() -> Double? {
        var result: Double = 0.0
        return scanDouble(&result) ? result : nil
    }
    
    func scanHexUInt32() -> UInt32? {
        var result: UInt32 = 0
        return scanHexInt(&result) ? result : nil
    }
    
    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexLongLong(&result) ? result : nil
    }
    
    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }
    
    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }
    
    func scanString(string: String) -> String? {
        var result: NSString? = nil
        if scanString(string, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func scanCharactersFromSet(set: NSCharacterSet) -> String? {
        var result: NSString? = nil
        if scanCharactersFromSet(set, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func scanUpToString(string: String) -> String? {
        var result: NSString? = nil
        if scanUpToString(string, intoString: &result) {
            return result as? String
        }
        return nil
    }
    
    func scanUpToCharactersFromSet(set: NSCharacterSet) -> String? {
        var result: NSString? = nil
        if scanUpToCharactersFromSet(set, intoString: &result) {
            return result as? String
        }
        return nil
    }
}
