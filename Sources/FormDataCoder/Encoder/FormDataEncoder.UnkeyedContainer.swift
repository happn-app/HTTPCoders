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



extension FormDataEncoder {
	
	struct UnkeyedContainer {
		
		let dataContainer = UnkeyedDataContainer()
		let encoder: FormDataEncoder.Encoder
		
	}
	
}


extension FormDataEncoder.UnkeyedContainer: UnkeyedEncodingContainer {
	
	var codingPath: [CodingKey] {
		encoder.codingPath
	}
	
	var count: Int {
		dataContainer.value.count
	}
	
	func encodeNil() throws {
		/* skip */
	}
	
	func encode<T: Encodable>(_ value: T) throws {
		try nextEncoder().encode(value)
	}
	
	func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
		nextEncoder().container(keyedBy: keyType)
	}
	
	func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
		nextEncoder().unkeyedContainer()
	}
	
	func superEncoder() -> Encoder {
		nextEncoder()
	}
	
	func nextEncoder() -> FormDataEncoder.Encoder {
		let encoder = self.encoder.nested(at: BasicCodingKey.index(count))
		dataContainer.value.append(encoder.storage)
		return encoder
	}
	
}
