//
// Runloop.swift
//
// Copyright (c) 2016 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public extension NSRunLoop {
	public func runOnce() {
		run(mode: NSDefaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.01))
	}
	
	public func waitForSemaphore(_ sem: dispatch_semaphore_t) {
		repeat {
			runOnce()
		} while 0 != dispatch_semaphore_wait(sem, DISPATCH_TIME_NOW)
	}
}
