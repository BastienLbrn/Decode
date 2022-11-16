import XCTest
@testable import Decode

final class DecodeTests: XCTestCase {
    
    // Calculated frames from: https://convertcodes.com
    
    func test_utf16Encoding_banane() {
        XCTAssertEqual(banane.toHexEncodedString(), bananeUTF16)
        XCTAssertEqual(empty.toHexEncodedString(), emptyUTF16)
    }
    
    func test_utf16Decoding_banane() {
        XCTAssertEqual(bananeUTF16.fromUTF16, banane)
        XCTAssertEqual(emptyUTF16.fromUTF16, empty)
    }
    
    func test_leadingCompletion() {
        XCTAssertEqual(banane.complete(with: "X", desiredSize: 30, position: .start), bananeLeadingWithX30)
        XCTAssertEqual(empty.complete(with: "X", desiredSize: 30, position: .start), emptyLeadingWithX30)
    }
    
    func test_trailingCompletion() {
        XCTAssertEqual(banane.complete(with: "X", desiredSize: 20, position: .end), bananeTrailingWithX20)
        XCTAssertEqual(empty.complete(with: "X", desiredSize: 20, position: .end), emptyTrailingWithX20)
    }
    
    // MARK: - Helpers & data
    
    let banane = "Banane1234"
    let bananeUTF16 = "00420061006E0061006E00650031003200330034"
    let bananeLeadingWithX30 = "XXXXXXXXXXXXXXXXXXXXBanane1234"
    let bananeTrailingWithX20 = "Banane1234XXXXXXXXXX"
    
    let empty = ""
    let emptyUTF16 = ""
    let emptyLeadingWithX30 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    let emptyTrailingWithX20 = "XXXXXXXXXXXXXXXXXXXX"
    
}
