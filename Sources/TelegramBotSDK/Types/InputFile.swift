//
// InputFile.swift
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
import SwiftyJSON

/// Represents the contents of a file to be uploaded. Must be posted using multipart/form-data in the usual way that files are uploaded via the browser..
/// - SeeAlso: <https://core.telegram.org/bots/api#inputfile>

public class InputFile {
    var filename: String
    var data: Data
    var mimeType: String?
    
    public init(filename: String, data: Data, mimeType: String? = nil) {
        self.filename = filename
        self.data = data
        self.mimeType = mimeType
    }
}
