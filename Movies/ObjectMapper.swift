//
//  ObjectMapper.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ListTransform<T: RealmSwift.Object>: TransformType where T: Mappable {
    
    public init() { }
    
    public typealias Object = List<T>
    public typealias JSON = Array<Any>
    
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        if let objects = Mapper<T>().mapArray(JSONObject: value) {
            let list = List<T>()
            list.append(objectsIn: objects)
            return list
        }
        return nil
    }
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.flatMap { $0.toJSON() }
    }
}

class ListTransformString: TransformType {
    
    typealias Object = List<String>
    typealias JSON = Array<String>
    
    func transformFromJSON(_ value: Any?) -> List<String>? {
    
        if let arrayString = value as? Array<String> {
            let listString = List<String>()
            listString.append(objectsIn: arrayString)
            return listString
        }
        return nil
    }
    
    func transformToJSON(_ value: List<String>?) -> Array<String>? {
        
        if let value = value {
            var arrayString = Array<String>()
            for singleString in value {
                arrayString.append(singleString)
            }
            return arrayString
        }
        return nil
    }
}

class DateTransform: TransformType {
    
    typealias Object = Date
    typealias JSON = String
    var formatter: DateFormatter
    
    init(formatter: String) {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = formatter
    }
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return self.formatter.date(from: dateString)
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        if let value = value {
            return self.formatter.string(from: value)
        }
        return nil
    }
}
