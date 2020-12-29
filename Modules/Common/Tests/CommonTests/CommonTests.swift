import XCTest
import Nimble
@testable import Common

final class CommonTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        expect("Hello, World!") == "Hello, World!"
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
