//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

internal final class FromJSON {
	
	/// Basic type
	class func basicType<FieldType>(inout field: FieldType, object: FieldType?) -> FieldType? {
		if let value = object {
			field = value
			return value
		}
		return nil
	}

	/// optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) -> FieldType? {
		if let value = object {
			field = value
			return value
		}
		return nil
	}

	/// Implicitly unwrapped optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) -> FieldType? {
		if let value = object {
			field = value
			return value
		}
		return nil
	}

	/// Mappable object
	class func object<N: Mappable>(inout field: N, object: AnyObject?) -> N? {
		if let value: N = Mapper().map(object) {
			field = value
            return value
		}
        return nil
	}

	/// Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N?, object: AnyObject?) -> N? {
        let value : N? = Mapper().map(object)
        field = value
        return value
	}

	/// Implicitly unwrapped Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N!, object: AnyObject?) -> N? {
        let value : N! = Mapper().map(object)
        field = value
        return value
    }

    //TODO: The same needs to be done for object and dictionary!
	/// mappable object array
    class func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?, checkMapping:Bool = false) -> FailableOf<[N]> {
        if (checkMapping) {
            let mappingResult : FailableOf<[N]> = Mapper<N>().failableMapArray(object)
            if let objects = mappingResult.value {
                field = objects
            }
            return mappingResult
        } else {
            let parsedObjects = Mapper<N>().mapArray(object)

            if let objects = parsedObjects {
                field = objects
                return FailableOf(objects)
            }
            return FailableOf([] as [N])
        }
	}

	/// optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?, checkMapping:Bool = false) -> FailableOf<[N]>{
        if (checkMapping) {
            let mappingResult : FailableOf<[N]> = Mapper<N>().failableMapArray(object)
            field = mappingResult.value
            return mappingResult
        } else {
            let value :Array<N>? = Mapper().mapArray(object)
            field = value
            if let value = value {
                return FailableOf(value)
            } else {
                return FailableOf<[N]>([] as [String])
            }
        }
	}

	/// Implicitly unwrapped optional mappable object array
    class func optionalObjectArray<N: Mappable>(inout field: Array<N>!, object: AnyObject?, checkMapping: Bool = false) -> FailableOf<[N]>{
        if (checkMapping) {
            let mappingResult : FailableOf<[N]> = Mapper<N>().failableMapArray(object)
            field = mappingResult.value
            return mappingResult
        } else {
            let value :Array<N>? = Mapper().mapArray(object)
            field = value
            if let value = value {
                return FailableOf(value)
            } else {
                return FailableOf<[N]>([] as [String])
            }
        }
    }
	
	/// Dctionary containing Mappable objects
	class func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) -> Dictionary<String,N>? {
		let parsedObjects = Mapper<N>().mapDictionary(object)

		if let objects = parsedObjects {
			field = objects
            return objects
		}
        return nil
	}

	/// Optional dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) -> Dictionary<String,N>? {
        let value:Dictionary<String,N>? = Mapper().mapDictionary(object)
        field = value
        return value
	}

	/// Implicitly unwrapped Dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, object: AnyObject?) -> Dictionary<String,N>? {
        let value:Dictionary<String,N>? = Mapper().mapDictionary(object)
        field = value
        return value
	}
}
