// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

/// Reads token from environment variable or from a file.
///
/// - Returns: token.
public func readToken(_ name: String) -> String {
	let environment = NSProcessInfo.processInfo().environment
	var token = environment[name]
	if token == nil {
		do {
			token = try String(contentsOfFile: "test_bot_token.txt", encoding: NSUTF8StringEncoding)
			token?.trim()
		} catch {
		}
	}
	if let token = token {
		return token
	}
	print("\n" +
		"-----\n" +
		"ERROR\n" +
		"-----\n" +
	  	"Please create either:\n" +
	  	"  - an environment variable named \(name)\n" +
	  	"  - a file named \(name)\n" +
	  	"containing your bot's token.\n\n")
	exit(1)
}

