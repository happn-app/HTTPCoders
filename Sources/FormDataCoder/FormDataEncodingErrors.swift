import Foundation



public enum FormDataCoderError : Sendable, Error {
	
	case cannotWriteToStream(Error?)
	case syntaxErrorInSerializedMultipart
	
	case internalError
	
}

typealias Err = FormDataCoderError
