//
// HTTPUtils.swift
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


public class HTTPUtils {
    /// Encodes keys and values in a dictionary for using with
    /// `application/x-www-form-urlencoded` Content-Type and
    /// joins them into a single string.
    ///
    /// Keys corresponding to nil values are skipped and
    /// are not added to the resulting string.
    ///
    /// - SeeAlso: Encoding is performed using String's `formUrlencode` method.
    /// - Returns: Encoded string.
    public class func formUrlencode(_ dictionary: [String: Any?]) -> String {
        var result = ""
        for (key, valueOrNil) in dictionary {
            guard let value = valueOrNil else {
                // Ignore keys with nil values
                continue
            }
            
            var valueString: String
            
            if let boolValue = value as? Bool {
                if !boolValue {
                    continue
                }
                // If true, add "key=" to encoded string
                valueString = "true"
            } else if let arrayValue = value as? [InternalJsonConvertible] {
                
                let jsonArray = arrayValue.map({ (jsonObject) -> JSON in
                    return jsonObject.internalJson
                })
                
                let jsonConvertible = JSON(jsonArray)
                
                if let resultString = jsonConvertible.internalJson.rawString(options: JSONSerialization.WritingOptions()) {
                    valueString = String(describing: resultString)
                } else {
                    continue
                }
            } else {
                valueString = String(describing: value)
            }
            
            if !result.isEmpty {
                result += "&"
            }
            let keyUrlencoded = key.formUrlencode()
            let valueUrlencoded = valueString.formUrlencode()
            result += "\(keyUrlencoded)=\(valueUrlencoded)"
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
    
    public class func createMultipartFormDataBody(with parameters: [String: Any?], boundary: String) -> Data? {
        var body = Data()
        
        guard let boundary1 = "--\(boundary)\r\n".data(using: .utf8) else {
            return nil
        }
        guard let boundary2 = ("--\(boundary)--\r\n").data(using: .utf8) else {
            return nil
        }
        
        for (key, valueOrNil) in parameters {
            
            guard let value = valueOrNil else {
                // Ignore keys with nil values
                continue
            }
            
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
                
            } else {
                var valueString: String
                
                if let boolValue = value as? Bool {
                    if !boolValue {
                        continue
                    }
                    // If true, add "key=" to encoded string
                    valueString = "true"
                } else {
                    valueString = String(describing: value)
                }
                
                guard let contentDisposition = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) else {
                    return nil
                }
                body.append(contentDisposition)
                guard let valueData = "\(valueString)\r\n".data(using: .utf8) else {
                    return nil
                }
                body.append(valueData)
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
