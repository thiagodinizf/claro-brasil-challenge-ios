//
//  Service.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

enum ResponseType {
    case search([Movie]?)
    case movie
    case images
    case videos
}

class MovieAPI {

    static func search(query: String) -> DataRequest {
        let params: Parameters = ["api_key": API_KEY, "language": LANGUAGE, "query": query]
        return Alamofire.request(BASE_URL + "search/movie", method: .get, parameters: params, encoding: URLEncoding.queryString)
    }
    
    static func movie(id: Int) -> DataRequest {
        let params: Parameters = ["api_key": API_KEY, "language": LANGUAGE]
        return Alamofire.request(BASE_URL + "movie/\(id)", method: .get, parameters: params, encoding: URLEncoding.queryString)
    }
    
    static func images(id: Int) -> DataRequest {
        let params: Parameters = ["api_key": API_KEY]
        return Alamofire.request(BASE_URL + "movie/\(id)/images", method: .get, parameters: params, encoding: URLEncoding.queryString)
    }
    
    static func videos(id: Int) -> DataRequest {
        let params: Parameters = ["api_key": API_KEY,"language": LANGUAGE]
        return Alamofire.request(BASE_URL + "movie/\(id)/videos", method: .get, parameters: params, encoding: URLEncoding.queryString)
    }
}

class MovieService: BaseService {
    
    var delegate: ResponseDelegate

    required init(delegate: ResponseDelegate) {
        self.delegate = delegate
    }
    
    func search(query: String) {
        MovieAPI.search(query: query).validate().responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success(let value):
                self.delegate.success(type: .search(value))
            case .failure:
                self.delegate.failure(type: .search(nil), errorType: self.getError(response: response))
            }
        }
    }
    
    func movie(id: Int) {
        MovieAPI.movie(id: id).validate().responseObject { (response: DataResponse<Movie>) in
            switch response.result {
            case .success(let value):
                Movie.save(movie: value)
                self.delegate.success(type: .movie)
                self.videos(id: id)
            case .failure:
                self.delegate.failure(type: .movie, errorType: self.getError(response: response))
            }
        }
    }

    private func videos(id: Int) {
        MovieAPI.videos(id: id).validate().responseArray(keyPath: "results") { (response: DataResponse<[Video]>) in
            switch response.result {
            case .success(let videos):
                if let video = videos.first {
                    Movie.appendTrailer(id: id, trailer: video.key)
                }
                self.delegate.success(type: .videos)
                self.images(id: id)
            case .failure:
                self.delegate.failure(type: .videos, errorType: self.getError(response: response))
            }
        }
    }
    
    private func images(id: Int) {
        MovieAPI.images(id: id).validate().responseArray(keyPath: "backdrops") { (response: DataResponse<[Backdrop]>) in
            switch response.result {
            case .success(let backdrops):
                if !backdrops.isEmpty {
                    Movie.appendBackdrops(id: id, backdrops: backdrops.map({$0.path}))
                }
                self.delegate.success(type: .images)
            case .failure:
                self.delegate.failure(type: .images, errorType: self.getError(response: response))
            }
        }
    }
}
