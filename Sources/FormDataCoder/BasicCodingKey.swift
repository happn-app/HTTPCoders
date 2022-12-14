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



/** A basic `CodingKey` implementation. */
internal enum BasicCodingKey: CodingKey {
	
	case key(String)
	case index(Int)
	
	/** See `CodingKey`. */
	var stringValue: String {
		switch self {
			case .index(let index): return index.description
			case .key(let key): return key
		}
	}
	
	/** See `CodingKey`. */
	var intValue: Int? {
		switch self {
			case .index(let index): return index
			case .key(let key): return Int(key)
		}
	}
	
	/** See `CodingKey`. */
	init?(stringValue: String) {
		self = .key(stringValue)
	}
	
	/** See `CodingKey`. */
	init?(intValue: Int) {
		self = .index(intValue)
	}
	
	static let `super` = Self.key("super")
	
}
