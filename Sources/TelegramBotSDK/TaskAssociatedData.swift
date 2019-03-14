//
// TaskAssociatedData.swift
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

public class TaskAssociatedData {
    /// If no networking errors occur and the data returned by the server
    /// is parsed successfully, this handler will be called
    internal var completion: TelegramBot.DataTaskCompletion?
    
    /// Current number of reconnect attempts
    public var retryCount: Int = 0
    
    init(_ completion: @escaping TelegramBot.DataTaskCompletion = { _, _ in }) {
        self.completion = completion
    }
}
