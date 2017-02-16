//
// NSRunLoop+Utils.swift
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
import Dispatch

public extension RunLoop {
	public func waitForSemaphore(_ sem: DispatchSemaphore) {
        #if os(Linux)
		while true {
            // Bug workaround:
            // RunLoop.run() on Linux waits in a busy loop producing high CPU usage. Also, it freezes if
            // time interval is too small or negative. So, pick a minimal time interval when it still
            // doesn't freeze and add usleep(). This will minimize CPU usage when idling.
            let _ = run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.002))
		    if .success == sem.wait(timeout: DispatchTime.now()) {
                break
            }
            usleep(100000)
        }
        #else
		repeat {
            run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.01))
		} while .success != sem.wait(timeout: DispatchTime.now())
        #endif
	}
}
