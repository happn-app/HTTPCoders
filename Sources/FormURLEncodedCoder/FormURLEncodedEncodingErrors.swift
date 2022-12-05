import Foundation



public enum FormURLEncodedCoderError : Error, Sendable {
	
	case malformedKey(key: Substring)
	
	case iso8601DateFormatterUnavailable
	
}

typealias Err = FormURLEncodedCoderError
