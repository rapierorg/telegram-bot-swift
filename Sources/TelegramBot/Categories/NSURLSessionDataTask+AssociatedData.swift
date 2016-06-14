// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public extension URLSessionDataTask {
    
    private static var taskAssociatedDataKey = "taskAssociatedData"
    
    /// Returns data associated with task if any.
    var associatedData: TaskAssociatedData? {
        get {
            return objc_getAssociatedObject(self,
                &URLSessionDataTask.taskAssociatedDataKey) as? TaskAssociatedData
        }
        set {
            objc_setAssociatedObject(self, &URLSessionDataTask.taskAssociatedDataKey,
                newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
