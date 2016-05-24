// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension Router {
	// add() taking string
	
	public func add(_ commandString: String, slash: Command.SlashMode = .Optional, _ handler: (Arguments) throws -> Bool) {
		add(Command(commandString, slash: slash), handler)
	}
	
	public func add(_ commandString: String, slash: Command.SlashMode = .Optional, _ handler: (Arguments) throws->()) {
		add(Command(commandString, slash: slash), handler)
	}

	public func add(_ commandString: String, slash: Command.SlashMode = .Optional, _ handler: () throws->(Bool)) {
		add(Command(commandString, slash: slash), handler)
	}

	public func add(_ commandString: String, slash: Command.SlashMode = .Optional, _ handler: () throws->()) {
		add(Command(commandString, slash: slash), handler)
	}
	
	// Subscripts taking Command
	
	public subscript(command: Command) -> (Arguments) throws->Bool {
		get { fatalError("Not implemented") }
		set { add(command, newValue) }
	}
	
	public subscript(command: Command) -> (Arguments) throws->() {
		get { fatalError("Not implemented") }
		set { add(command, newValue) }
	}
	
	public subscript(command: Command) -> () throws->Bool {
		get { fatalError("Not implemented") }
		set { add(command, newValue) }
	}
	
	public subscript(command: Command) -> () throws->() {
		get { fatalError("Not implemented") }
		set { add(command, newValue) }
	}
	
	// Subscripts taking String
	
	public subscript(commandString: String) -> (Arguments) throws -> Bool {
		get { fatalError("Not implemented") }
		set { add(Command(commandString), newValue) }
	}

	public subscript(commandString: String, slash slash: Command.SlashMode) -> (Arguments) throws -> Bool {
		get { fatalError("Not implemented") }
		set { add(Command(commandString, slash: slash), newValue) }
	}

	public subscript(commandString: String) -> (Arguments) throws->() {
		get { fatalError("Not implemented") }
		set { add(Command(commandString), newValue) }
	}

	public subscript(commandString: String, slash slash: Command.SlashMode) -> (Arguments) throws->() {
		get { fatalError("Not implemented") }
		set { add(Command(commandString, slash: slash), newValue) }
	}

	public subscript(commandString: String) -> () throws->(Bool) {
		get { fatalError("Not implemented") }
		set { add(Command(commandString), newValue) }
	}

	public subscript(commandString: String, slash slash: Command.SlashMode) -> () throws->(Bool) {
		get { fatalError("Not implemented") }
		set { add(Command(commandString, slash: slash), newValue) }
	}

	public subscript(commandString: String) -> () throws->() {
		get { fatalError("Not implemented") }
		set { add(Command(commandString), newValue) }
	}

	public subscript(commandString: String, slash slash: Command.SlashMode) -> () throws->() {
		get { fatalError("Not implemented") }
		set { add(Command(commandString, slash: slash), newValue) }
	}
}
