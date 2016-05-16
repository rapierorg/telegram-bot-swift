// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Path {
    public enum Handler {
        case CancellableHandlerWithoutArguments(()->(Bool))
        case CancellableHandlerWithoutArgumentsThrows(() throws->(Bool))
        case NonCancellableHandlerWithoutArguments(()->())
        case NonCancellableHandlerWithoutArgumentsThrows(() throws->())
        case CancellableHandlerWithArguments((Arguments)->(Bool))
        case CancellableHandlerWithArgumentsThrows((Arguments) throws->(Bool))
        case NonCancellableHandlerWithArguments((Arguments)->())
        case NonCancellableHandlerWithArgumentsThrows((Arguments) throws->())
    }
    
    public var parameters: [Parameter]
    public var handler: Handler
    
    init (parameters: [Parameter], handler: Path.Handler) {
        self.parameters = parameters
        self.handler = handler
    }
}
