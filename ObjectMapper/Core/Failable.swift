//
//  Failable.swift
//  ObjectMapper
//
//  Created by Johan Rugager Vase on 29/04/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation

/**
* A `FailableOf<T>` should be returned from functions that need to return success or failure information and some
* corresponding data back upon a successful function call.
*/
public enum FailableOf<T> {
	case Success(FailableValueWrapper<T>)
	case Failure([String])
	
	public init(_ value: T) {
		self = .Success(FailableValueWrapper(value))
	}
	
	public init(_ mappingErrors: [String]) {
		self = .Failure(mappingErrors)
	}
	
	public var failed: Bool {
		switch self {
		case .Failure(let error):
			return true
			
		default:
			return false
		}
	}
	
	public var error: [String]? {
		switch self {
		case .Failure(let error):
			return error
			
		default:
			return nil
		}
	}
	
	public var value: T? {
		switch self {
		case .Success(let wrapper):
			return wrapper.value
			
		default:
			return nil
		}
	}
}

/// This is a workaround-wrapper class for a bug in the Swift compiler. DO NOT USE THIS CLASS!!
public class FailableValueWrapper<T> {
	public let value: T
	public init(_ value: T) { self.value = value }
}