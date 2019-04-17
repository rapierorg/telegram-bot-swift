//
// InputFileOrString.swift
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


public enum InputFileOrString: JsonConvertible, InternalJsonConvertible {
    public init(json: Any) {
        self.init(internalJson: JSON(json))
    }
    
    case inputFile(InputFile)
    case string(String)
    
    internal init(internalJson: JSON) {
        if nil != internalJson.string {
            self = .string(String(internalJson: internalJson))
        } else {
            self = .inputFile(InputFile(filename: "", data: Data()))
        }
    }
    
    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
    
    internal var internalJson: JSON {
        get {
            switch self {
            case .inputFile(let _): return JSON()
            case .string(let string): return string.internalJson
            }
        }
        set {
            self = InputFileOrString(json: internalJson)
        }
    }
}
