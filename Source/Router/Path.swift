//
// Path.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/Path {
    public enum Handler {
        case CancellableHandlerWithoutArguments(()->(Bool))
        case NonCancellableHandlerWithoutArguments(()->())
        case CancellableHandlerWithArguments((/*NS*/Arguments)->(Bool))
        case NonCancellableHandlerWithArguments((/*NS*/Arguments)->())
    }
    
    public var parameters: [/*NS*/Parameter]
    public var handler: Handler
    
    init (parameters: [/*NS*/Parameter], handler: /*NS*/Path.Handler) {
        self.parameters = parameters
        self.handler = handler
    }
}
