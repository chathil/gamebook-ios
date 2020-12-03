import XCTest
@testable import User

final class UserTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(User().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
