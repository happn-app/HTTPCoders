import Foundation
import XCTest

@testable import FormDataCoder



class Bob : Equatable, Encodable, Decodable, MultipartPartConvertible {
	
	static func ==(lhs: Bob, rhs: Bob) -> Bool {
		return true
	}
	
	var multipart: MultipartPart? {
		return MultipartPart(headers: HTTPHeaders(dictionaryLiteral: ("yo", "magueule")), body: "sup")
	}
	
	init() {
	}
	
	required init?(multipart: MultipartPart) {
	}
	
}


class FormDataEncoderTests : XCTestCase {
	
	func testBasicEncode() throws {
		let toEncode = ["Hello": "World"]
		let encoded = try FormDataEncoder().encode(toEncode, boundary: "123")
		let decoded = try FormDataDecoder().decode([String: String].self, from: encoded, boundary: "123")
		XCTAssertEqual(toEncode, decoded)
	}
	
	func testEncodeBob() throws {
		let toEncode = ["Hello": Bob()]
		let encoded = try FormDataEncoder().encode(toEncode, boundary: "123")
		let decoded = try FormDataDecoder().decode([String: Bob].self, from: encoded, boundary: "123")
		XCTAssertEqual(toEncode, decoded)
	}
	
	func testEmptyEncode() throws {
#warning("TODO: Fix implementation of decoder (or encoder, or both) to make this test pass.")
#if !os(Linux)
		XCTExpectFailure("Not properly implemented yet.")
#endif
		
		let toEncode: [String] = []
		let encoded = try FormDataEncoder().encode(toEncode, boundary: "123")
		let decoded = try FormDataDecoder().decode([String].self, from: encoded, boundary: "123")
		XCTAssertEqual(toEncode, decoded)
	}
	
}
