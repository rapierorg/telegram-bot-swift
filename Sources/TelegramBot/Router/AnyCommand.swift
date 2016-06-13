// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class AnyCommand: Command {
	public init(slash: SlashMode = .required) {
		super.init("", slash: slash)
	}
}
