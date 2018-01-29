//
//  Image.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import ObjectMapper

class Backdrop: Mappable {
    
    var path = ""
    var height = 0
    var width = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        path <- map["file_path"]
        height <- map["height"]
        width <- map["width"]
    }
}
