// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public enum Handler {
	case CancellableHandlerWithoutArguments(() throws->(Bool))
	case NonCancellableHandlerWithoutArguments(() throws->())
	case CancellableHandlerWithArguments((ArgumentScanner) throws->(Bool))
	case NonCancellableHandlerWithArguments((ArgumentScanner) throws->())
}
