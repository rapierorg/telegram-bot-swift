//
// DictionaryUtils.swift
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

/*
func + <K,V> (left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
	guard let right = right else { return left }
	return left.reduce(right) {
		var new = $0 as [K:V]
		new.updateValue($1.1, forKey: $1.0)
		return new
	}
}
*/

/*
func += <K,V> (left: inout Dictionary<K,V>, right: Dictionary<K,V>?) {
	guard let right = right else { return }
	right.forEach { key, value in
		left.updateValue(value, forKey: key)
	}
}
*/
