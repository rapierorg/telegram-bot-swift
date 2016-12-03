//
// String+HTTP.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

extension String {
    struct HTTPData {
        // "0123456789ABCDEF"
        static let hexDigits: [CChar] = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70]
        
        static let formUrlencodedAllowedCharacters: CharacterSet = {
            var cs = CharacterSet()
            cs.insert(charactersIn:
                "0123456789" +
                "abcdefghijklmnopqrstuvwxyz" +
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
                "-._* ")
            return cs
        }()
        
        static let urlQueryAllowedCharacters: CharacterSet = {
            var cs = CharacterSet()
			cs.insert(charactersIn:
                "0123456789" +
                "abcdefghijklmnopqrstuvwxyz" +
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
                "-._~")
            return cs
        }()
    }
    
    /// Replaces spaces with `'+'`, percent-encodes everything
    /// else except alphanumerics and `'-._*'`
    ///
    /// Should be used for encoding parameter values when
    /// using `application/x-www-form-urlencoded` Content-Type.
    ///
    /// - SeeAlso: `func urlQueryEncode() -> String`
    /// - Returns: Encoded string
    public func formUrlencode() -> String {
        #if os(Linux)
        // https://bugs.swift.org/browse/SR-3216
        let encoded = _addingPercentEncoding(withAllowedCharacters: HTTPData.formUrlencodedAllowedCharacters)
        #else
        let encoded = addingPercentEncoding(withAllowedCharacters: HTTPData.formUrlencodedAllowedCharacters)
        #endif
        return encoded?.replacingOccurrences(of: " ", with: "+") ?? ""
    }
    
    /// Percent-encodes everything except alphanumerics
    /// and `'-._~'`.
    ///
    /// Should be used for encoding URL query components.
    ///
    /// - Returns: Encoded string
    /// - SeeAlso: `func formUrlencode() -> String`
    public func urlQueryEncode() -> String {
        #if os(Linux)
        // https://bugs.swift.org/browse/SR-3216
        return _addingPercentEncoding(withAllowedCharacters: HTTPData.urlQueryAllowedCharacters) ?? ""
        #else
		return addingPercentEncoding(withAllowedCharacters: HTTPData.urlQueryAllowedCharacters) ?? ""
        #endif
    }
    
    private func _addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        // Workaround broken addingPercentEncoding()
        var result: [CChar] = []
        for byte in utf8 {
            let scalar = UnicodeScalar(byte)
            if allowedCharacters.contains(scalar) {
                result.append(CChar(bitPattern: byte))
            } else {
                result.append(37) // "%"
                result.append(HTTPData.hexDigits[Int((byte & 0xf0) >> 4)])
                result.append(HTTPData.hexDigits[Int(byte & 0x0f)])
            }
        }
        result.append(0)
        let encoded = String(cString: result, encoding: .utf8)
        return encoded
    }
}
