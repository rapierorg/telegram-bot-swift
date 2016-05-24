// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

extension Router {
	public func add(_ commandString: String, _ handler: (ArgumentScanner) throws -> Bool) {
		add(Command(commandString), handler)
	}
	
	public func add(_ commandString: String, _ handler: (ArgumentScanner) throws->()) {
		add(Command(commandString), handler)
	}

	public func add(_ commandString: String, _ handler: () throws->(Bool)) {
		add(Command(commandString), handler)
	}

	public func add(_ commandString: String, _ handler: () throws->()) {
		add(Command(commandString), handler)
	}
	
	public subscript(commandString: String) -> (ArgumentScanner) throws -> Bool {
		get {
			fatalError("Not implemented")
		}
		set {
			add(Command(commandString), newValue)
		}
	}

	public subscript(commandString: String) -> (ArgumentScanner) throws->() {
		get {
			fatalError("Not implemented")
		}
		set {
			add(Command(commandString), newValue)
		}
	}

	public subscript(commandString: String) -> () throws->(Bool) {
		get {
			fatalError("Not implemented")
		}
		set {
			add(Command(commandString), newValue)
		}
	}

	public subscript(commandString: String) -> () throws->() {
		get {
			fatalError("Not implemented")
		}
		set {
			add(Command(commandString), newValue)
		}
	}
}
