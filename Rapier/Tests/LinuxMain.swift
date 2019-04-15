import XCTest

import rapierTests

var tests = [XCTestCaseEntry]()
tests += rapierTests.allTests()
XCTMain(tests)