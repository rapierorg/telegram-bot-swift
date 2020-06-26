//
// HTTPUtils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation

struct AnyEncodable: Encodable {
    let value: Encodable

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }
}

extension Encodable {
    func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

public class HTTPUtils {
    enum EncodeResult {
        case success(String)
        case skipThisValue
        case error
    }
    
    private class func encodeValue(_ value: Encodable) -> EncodeResult {
        if let boolValue = value as? Bool {
            if !boolValue {
                return .skipThisValue
            }
            // If true, add "key=" to encoded string
            return .success("true")
        }
        
        if let value = value as? String {
            return .success(value)
        }
        
        let encodableBox = AnyEncodable(value: value)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonEncodedData = try? encoder.encode(encodableBox)
        guard let jsonEncodedUnwrappedData = jsonEncodedData else { return .error }
        guard var jsonEncodedString = String(data: jsonEncodedUnwrappedData, encoding: .utf8) else { return .error }
        
        if jsonEncodedString.hasPrefix("\"") && jsonEncodedString.hasSuffix("\"") {
            jsonEncodedString = String(jsonEncodedString.dropFirst().dropLast())
        }
        
        return .success(jsonEncodedString)
    }
    
    /// Encodes keys and values in a dictionary for using with
    /// `application/x-www-form-urlencoded` Content-Type and
    /// joins them into a single string.
    ///
    /// Keys corresponding to nil values are skipped and
    /// are not added to the resulting string.
    ///
    /// - SeeAlso: Encoding is performed using String's `formUrlencode` method.
    /// - Returns: Encoded string.
    public class func formUrlencode(_ dictionary: [String: Encodable?]) -> String? {
        var result = ""
        for (key, valueOrNil) in dictionary {
            guard let value = valueOrNil else { continue }
            switch encodeValue(value) {
            case .success(let valueString):
                if !result.isEmpty {
                    result += "&"
                }
                let keyUrlencoded = key.formUrlencode()
                let valueUrlencoded = valueString.formUrlencode()
                result += "\(keyUrlencoded)=\(valueUrlencoded)"
            case .skipThisValue:
                continue
            case .error:
                return nil
            }
            
        }
        return result
    }
    
    /// Encodes keys and values in a dictionary for using with
    /// `application/x-www-form-urlencoded` Content-Type and
    /// joins them into a single string.
    ///
    /// - SeeAlso: Encoding is performed using String's `formUrlencode` method.
    /// - Returns: Encoded string.
    public class func formUrlencode(_ dictionary: [String: String]) -> String {
        var result = ""
        for (keyString, valueString) in dictionary {
            if !result.isEmpty {
                result += "&"
            }
            let keyUrlencoded = keyString.formUrlencode()
            let valueUrlencoded = valueString.formUrlencode()
            result += "\(keyUrlencoded)=\(valueUrlencoded)"
        }
        return result
    }

    // http://stackoverflow.com/questions/26162616/upload-image-with-parameters-in-swift

    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    public class func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
        //return "-----------------------------Boundary-\(NSUUID().uuidString)"
    }
    
    /// Create body of the multipart/form-data request
    ///
    /// - parameter parameters:   The dictionary containing keys and values to be passed to web service
    /// - parameter boundary:     The multipart/form-data boundary
    ///
    /// - returns:                The Data of the body of the request
    
    public class func createMultipartFormDataBody(with parameters: [String: Encodable?], boundary: String) -> Data? {
        var body = Data()
        
        guard let boundary1 = "--\(boundary)\r\n".data(using: .utf8) else {
            return nil
        }
        guard let boundary2 = ("--\(boundary)--\r\n").data(using: .utf8) else {
            return nil
        }
        
        for (key, valueOrNil) in parameters {
            guard let value = valueOrNil else { continue }
            
            body.append(boundary1)
            
            if let inputFile = value as? InputFile {
                let filename = inputFile.filename
                let mimetype = inputFile.mimeType ?? mimeType(for: filename)
                let data = inputFile.data
                guard let contentDisposition = "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8) else {
                    return nil
                }
                body.append(contentDisposition)
                guard let mimeType = "Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8) else {
                    return nil
                }
                body.append(mimeType)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            } else if let inputFileOrString = value as? InputFileOrString {
                if case InputFileOrString.inputFile(let inputFile) = inputFileOrString {
                    let filename = inputFile.filename
                    let mimetype = inputFile.mimeType ?? mimeType(for: filename)
                    let data = inputFile.data
                    guard let contentDisposition = "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8) else {
                        return nil
                    }
                    body.append(contentDisposition)
                    guard let mimeType = "Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8) else {
                        return nil
                    }
                    body.append(mimeType)
                    body.append(data)
                    body.append("\r\n".data(using: .utf8)!)
                }
            } else {
                switch encodeValue(value) {
                case .success(let valueString):
                    guard let contentDisposition = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) else {
                        return nil
                    }
                    body.append(contentDisposition)
                    guard let valueData = "\(valueString)\r\n".data(using: .utf8) else {
                        return nil
                    }
                    body.append(valueData)
                case .skipThisValue:
                    continue
                case .error:
                    return nil
                }
            }
        }
        body.append(boundary2)
        
        return body
    }
    
    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires MobileCoreServices framework.
    ///
    /// - parameter path:         The path of the file for which we are going to determine the mime type.
    ///
    /// - returns:                Returns the mime type if successful. Returns application/octet-stream if unable to determine mime type.
    
    public class func mimeType(for path: String) -> String {
        // TODO: https://gist.github.com/ngs/918b07f448977789cf69
        #if false
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        #endif
        return "application/octet-stream";
    }
}
