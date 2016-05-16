// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class TaskAssociatedData {
    /// If no networking errors occur and the data returned by the server
    /// is parsed successfully, this handler will be called
    public var completion: TelegramBot.DataTaskCompletion?
    
    /// Current number of reconnect attempts
    public var retryCount: Int = 0
    
    init(_ completion: TelegramBot.DataTaskCompletion?) {
        self.completion = completion
    }
}
