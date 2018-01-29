//
//  Video.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import ObjectMapper

class Video: Mappable {
    
    var id = ""
    var key = ""
    var site = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
        site <- map["site"]
    }
}
