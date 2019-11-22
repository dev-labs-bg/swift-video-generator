import XCTest
@testable import swift_video_generator

final class swift_video_generatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_video_generator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
