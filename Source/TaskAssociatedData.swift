//
// RequestAssociatedData.swift
//
// Copyright (c) 2015 Andrey Fidrya
//
// Licensed under the MIT license. For full copyright and license information,
// please see the LICENSE file.
//

import Foundation

public class /*NS*/TaskAssociatedData {
    /// If no networking errors occur and the data returned by the server
    /// is parsed successfully, this handler will be called
    public var completion: TelegramBot.DataTaskCompletion?
    
    /// Current number of reconnect attempts
    public var retryCount: Int = 0
    
    init(_ completion: TelegramBot.DataTaskCompletion?) {
        self.completion = completion
    }
}
