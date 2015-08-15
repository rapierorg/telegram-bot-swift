//
// NSURLSessionDataTask+AssociatedData.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public extension NSURLSessionDataTask {
    
    private static var taskAssociatedDataKey = "taskAssociatedData"
    
    /// Returns data associated with task if any.
    var associatedData: /*NS*/TaskAssociatedData? {
        get {
            return objc_getAssociatedObject(self,
                &NSURLSessionDataTask.taskAssociatedDataKey) as? /*NS*/TaskAssociatedData
        }
        set {
            objc_setAssociatedObject(self, &NSURLSessionDataTask.taskAssociatedDataKey,
                newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
