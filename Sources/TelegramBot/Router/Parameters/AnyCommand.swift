//
// Command.swift
//
// Copyright (c) 2016 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class AnyCommand: Command {
	public init(slash: SlashMode = .Required) {
		super.init("", slash: slash)
	}
}
