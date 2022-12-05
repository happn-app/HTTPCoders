/* From https://github.com/vapor/multipart-kit, 2dd9368a3c9580792b77c7ef364f3735909d9996
 * Original License:
 *    The MIT License (MIT)
 *
 *    Copyright (c) 2018 Qutheory, LLC
 *
 *    Permission is hereby granted, free of charge, to any person obtaining a copy
 *    of this software and associated documentation files (the "Software"), to deal
 *    in the Software without restriction, including without limitation the rights
 *    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *    copies of the Software, and to permit persons to whom the Software is
 *    furnished to do so, subject to the following conditions:
 *
 *    The above copyright notice and this permission notice shall be included in all
 *    copies or substantial portions of the Software.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *    SOFTWARE.
 */

import Foundation



extension FormDataDecoder.Decoder: SingleValueDecodingContainer {
	
	func decodeNil() -> Bool {
		false
	}
	
	func decode<T: Decodable>(_: T.Type = T.self) throws -> T {
		guard
			let part = data.part,
			let Convertible = T.self as? MultipartPartConvertible.Type
		else {
			return try T(from: self)
		}
		
		guard !data.hasExceededNestingDepth else {
			throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Nesting depth exceeded.", underlyingError: nil))
		}
		
		guard let decoded = Convertible.init(multipart: part) as? T else {
			let path = codingPath.map(\.stringValue).joined(separator: ".")
			throw DecodingError.dataCorrupted(
				.init(
					codingPath: codingPath,
					debugDescription: #"Could not convert value at "\#(path)" to type \#(T.self) from multipart part."#
				)
			)
		}
		return decoded
	}
	
}
