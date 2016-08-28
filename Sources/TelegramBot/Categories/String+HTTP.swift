// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension String {
    struct HTTPData {
        static let formUrlencodedAllowedCharacters: CharacterSet = {
            var cs = CharacterSet.alphanumerics
            cs.insert(charactersIn: "-._* ")
            return cs
        }()
        
        static let urlQueryAllowedCharacters: CharacterSet = {
            var cs = CharacterSet.alphanumerics
			cs.insert(charactersIn: "-._~")
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
    func formUrlencode() -> String {
        return addingPercentEncoding(withAllowedCharacters: HTTPData.formUrlencodedAllowedCharacters)?.replacingOccurrences(of: " ", with: "+") ?? ""
    }
    
    /// Percent-encodes everything except alphanumerics
    /// and `'-._~'`.
    ///
    /// Should be used for encoding URL query components.
    ///
    /// - Returns: Encoded string
    /// - SeeAlso: `func formUrlencode() -> String`
    func urlQueryEncode() -> String {
		return addingPercentEncoding(withAllowedCharacters: HTTPData.urlQueryAllowedCharacters) ?? ""
    }
}
