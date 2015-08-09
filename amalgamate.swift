#!/usr/bin/env swift

import Foundation

func main() -> Int32 {
	let sourcePath = "Source/"
	let sourceExtension = ".swift"
	let excludePaths = [
		"ThirdParty/SwiftyJSON/Example/"
	]
	let amalgamationFilename = "TelegramBot.swift"

	let fileManager = NSFileManager.defaultManager()

	guard let enumerator = fileManager.enumeratorAtPath(sourcePath) else {
		print("Unexistent path: \(sourcePath)")
		return 1
	}


	if !fileManager.fileExistsAtPath(amalgamationFilename) {
		fileManager.createFileAtPath(amalgamationFilename, contents: nil, attributes: nil)
	}

	guard let outFile = NSFileHandle(forWritingAtPath: amalgamationFilename) else {
		print("Unable to open amalgamation file for writing: \(amalgamationFilename)")
		return 1
	}
	defer {
		outFile.closeFile()
	}

	outFile.truncateFileAtOffset(0)

	var added = 0
	var skipped = 0

	while let element = enumerator.nextObject() as? String {
		let filename = (sourcePath as NSString).stringByAppendingPathComponent(element)

		guard element.hasSuffix(sourceExtension) else {
			print("Skipping (ext): \(filename)")
			++skipped
			continue
		}

		var exclude = false
		for excludePath in excludePaths {
			if element.rangeOfString(excludePath) != nil {
				exclude = true
				break
			}
		}
		if exclude {
			print("Skipping (exc): \(filename)")
			++skipped
			continue
		}

		var fileContents: String
		do {
			fileContents = try String(contentsOfFile: filename, encoding: NSUTF8StringEncoding)
		} catch {
			print("Unable to read file: \(filename): \(error)")
			return 1
		}

		if fileContents.rangeOfString("import XCTest") != nil {
			print("Skipping (tst): \(filename)")
			++skipped
			continue
		}

		fileContents = preprocess(fileContents, filename: element)

		guard let data = fileContents.dataUsingEncoding(NSUTF8StringEncoding) else {
			print("Invalid characters in text")
			return 1
		}
		outFile.writeData(data)

		++added
		print("Added: \(filename)")
	}
	print("")
	print("\(amalgamationFilename) created succesfully")
	print("\(added) file(s) added, \(skipped) file(s) skipped")
	print("")

	return 0
}

func preprocess(fileContents: String, filename: String) -> String {

	var fileContents = fileContents.stringByReplacingOccurrencesOfString("import SwiftyJSON\n", withString: "")

	fileContents = fileContents.stringByReplacingOccurrencesOfString("extension SwiftyJSON.JSON", withString: "extension JSON")

	fileContents = "\n" +
		"//\n" +
		"// \(filename)\n" +
		"//\n" +
		"\n" +
		fileContents

	return fileContents
}

exit(main())

