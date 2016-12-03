//
// Router+Helpers.swift
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

extension Router {
	// add() taking string
	
	public func add(_ commandString: String, _ options: Command.Options = [], _ handler: @escaping (Context) throws -> Bool) {
		add(Command(commandString, options: options), handler)
	}
		
	// Subscripts taking ContentType
	
	public subscript(_ contentType: ContentType) -> (Context) throws->Bool {
		get { fatalError("Not implemented") }
		set { add(contentType, newValue) }
	}
	
	// Subscripts taking Command
	
	public subscript(_ command: Command) -> (Context) throws->Bool {
		get { fatalError("Not implemented") }
		set { add(command, newValue) }
	}

    public subscript(_ commands: [Command]) -> (Context) throws->Bool {
        get { fatalError("Not implemented") }
        set { add(commands, newValue) }
    }
    
    public subscript(_ commands: Command...) -> (Context) throws->Bool {
        get { fatalError("Not implemented") }
        set { add(commands, newValue) }
    }
    
	// Subscripts taking String

	public subscript(_ commandString: String, _ options: Command.Options) -> (Context) throws -> Bool {
		get { fatalError("Not implemented") }
        set { add(Command(commandString, options: options), newValue) }
	}
    
    public subscript(_ commandString: String) -> (Context) throws -> Bool {
        get { fatalError("Not implemented") }
        set { add(Command(commandString), newValue) }
    }

    public subscript(_ commandStrings: [String], _ options: Command.Options) -> (Context) throws -> Bool {
        get { fatalError("Not implemented") }
        set {
            let commands = commandStrings.map { Command($0, options: options) }
            add(commands, newValue)
        }
    }
    
    public subscript(commandStrings: [String]) -> (Context) throws -> Bool {
        get { fatalError("Not implemented") }
        set {
            let commands = commandStrings.map { Command($0) }
            add(commands, newValue)
        }
    }

// Segmentation fault
//    public subscript(commandStrings: String..., _ options: Command.Options) -> (Context) throws -> Bool {
//        get { fatalError("Not implemented") }
//        set {
//            let commands = commandStrings.map { Command($0, options: options) }
//            add(commands, newValue)
//        }
//    }

    public subscript(commandStrings: String...) -> (Context) throws -> Bool {
        get { fatalError("Not implemented") }
        set {
            let commands = commandStrings.map { Command($0) }
            add(commands, newValue)
        }
    }
}
