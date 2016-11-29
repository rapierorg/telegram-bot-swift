// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

private var taskAssociatedDataHolder = [URLSessionDataTask: TaskAssociatedData]()

public extension URLSessionDataTask {
    /// Returns data associated with task if any.
    var associatedData: TaskAssociatedData? {
        get {
            return taskAssociatedDataHolder[self]
        }
        set {
            taskAssociatedDataHolder[self] = newValue
        }
    }
}
