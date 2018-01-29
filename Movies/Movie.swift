//
//  Movie.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Movie: Object, Mappable {

    @objc dynamic var id = 0
    @objc dynamic var title: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var overview: String?
    @objc dynamic var releaseDate: Date?
    @objc dynamic var favorite: Bool = false
    @objc dynamic var trailer: String?
    var backdrops = List<String>()

    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        overview <- map["overview"]
        releaseDate <- (map["release_date"], DateTransform(formatter: datePattern))
    }
}

extension Movie {
    
    static func save(movie: Movie) {
        if let movieDB = self.getByID(movie.id) {
            movie.favorite = movieDB.favorite
        }
        try! realmDB.write {
            realmDB.add(movie, update: true)
        }
    }
    
    static func getByID(_ id: Int) -> Movie? {
        return realmDB.objects(Movie.self).filter("id = \(id)").first
    }
    
    static func getFavorites() -> Results<Movie> {
        return realmDB.objects(Movie.self).filter("favorite = true")
    }
    
    static func appendBackdrops(id: Int, backdrops: [String]) {
        if let movie = self.getByID(id) {
            try! realmDB.write {
                movie.backdrops.append(objectsIn: backdrops)
            }
        }
    }
    
    static func appendTrailer(id: Int, trailer: String) {
        if let movie = self.getByID(id) {
            try! realmDB.write {
                movie.trailer = trailer
            }
        }
    }
    
    static func favorite(_ id: Int, isSelected: Bool) {
        if let movieDB = self.getByID(id) {
            try! realmDB.write {
                movieDB.favorite = isSelected
            }
        }
    }
}
