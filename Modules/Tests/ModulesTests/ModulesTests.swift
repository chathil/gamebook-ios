import XCTest
@testable import Modules

final class ModulesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Modules().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
