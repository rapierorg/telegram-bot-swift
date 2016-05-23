// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

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
