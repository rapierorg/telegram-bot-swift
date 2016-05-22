// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public enum Handler {
	case CancellableHandlerWithoutArguments(()->(Bool))
	case CancellableHandlerWithoutArgumentsThrows(() throws->(Bool))
	case NonCancellableHandlerWithoutArguments(()->())
	case NonCancellableHandlerWithoutArgumentsThrows(() throws->())
	case CancellableHandlerWithArguments((ArgumentScanner)->(Bool))
	case CancellableHandlerWithArgumentsThrows((ArgumentScanner) throws->(Bool))
	case NonCancellableHandlerWithArguments((ArgumentScanner)->())
	case NonCancellableHandlerWithArgumentsThrows((ArgumentScanner) throws->())
}
