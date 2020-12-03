import XCTest

import UserTests

var tests = [XCTestCaseEntry]()
tests += UserTests.allTests()
XCTMain(tests)
