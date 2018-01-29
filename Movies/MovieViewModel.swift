//
//  MovieViewModel.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
    
    var movie: Movie
    
    init(withMovie movie: Movie) {
        self.movie = movie.detached()
    }
    
    var id: Int {
        return movie.id
    }
    
    var titleText: String {
        if let title = self.movie.title, !title.isEmpty {
            return title
        }
       return L10n.Default.notAvailable
    }
    var posterURL: URL? {
        if let posterPath = self.movie.posterPath {
            return URL(string: "\(IMG_BASE_URL)\(ItemSize.posterWidthForPath())\(posterPath)")
        }
        return nil
    }
    var backdropURL: URL? {
        if let backdropPath = self.movie.backdropPath {
            return URL(string: "\(IMG_BASE_URL)\(ItemSize.backdropWidthForPath())\(backdropPath)")
        }
        return nil
    }
    var overviewText: String {
        if let overview = self.movie.overview, !overview.isEmpty {
            return overview
        }
        return L10n.Default.notAvailable
    }
    
    var releaseDate: String {
        if let date = self.movie.releaseDate {
            let calendar = Calendar.current
            return String(calendar.component(.year, from: date))
        }
        return ""
    }
    
    var trailerURL: URL? {
        if let key = movie.trailer {
            return URL(string: "\(YOUTUBE_BASE_URL)\(key)")
        }
        return nil
    }
    
    var trailerThumbnail: URL? {
        if let key = movie.trailer {
            return URL(string: "\(YOUTUBE_THUMBNAIL_BASE_URL)\(key)/\(ItemSize.youtubeThumbnailQuality())")
        }
        return nil
    }
    
    func numberOfSections() -> Int {
        return MovieSectionType.count
    }
    
    func numerOfRows(_ section: Int) -> Int {
        switch MovieSectionType.type(section) {
        case .overview:
            return 1
        case .videos:
            return self.trailerURL == nil ? 0 : 1
        case .images:
            return movie.backdrops.isEmpty ? 0 : 1
        }
    }
    
    func titleOfSection(_ section: Int) -> String {
        return MovieSectionType.type(section).title
    }
    
    func heighForRow(_ section: Int) -> CGFloat {
        switch MovieSectionType.type(section) {
        case .overview:
            return UITableViewAutomaticDimension
        case .videos, .images:
            return 120
        }
    }
    
    func heightForHeader(_ section: Int) -> CGFloat {
        switch MovieSectionType.type(section) {
        case .overview:
            return 30
        case .videos:
            return trailerURL == nil ? 0 : 30
        case .images:
            return images.isEmpty ? 0 : 30
        }
    }
    func heightForFooter(_ section: Int) -> CGFloat {
        switch MovieSectionType.type(section) {
        case .overview:
            return 20
        case .videos:
            return trailerURL == nil ? 0 : 20
        case .images:
            return images.isEmpty ? 0 : 20
        }
    }
    
    var images: [String] {
        var list: [String] = []
        for image in self.movie.backdrops {
            list.append("\(IMG_BASE_URL)\(ItemSize.backdropWidthForPath())\(image)")
        }
        return list
    }
}

extension MovieViewModel {
    
    static func movieAsView(_ movie: Movie) -> MovieViewModel {
        return MovieViewModel(withMovie: movie)
    }
    
    static func moviesAsView(_ movies: [Movie]) -> [MovieViewModel] {
        var moviesView: [MovieViewModel] = []
        for movie in movies {
            moviesView.append(MovieViewModel.movieAsView(movie))
        }
        return moviesView
    }
    
    static func getMovie(_ id: Int) -> MovieViewModel? {
        if let movieDB = Movie.getByID(id){
            return MovieViewModel.movieAsView(movieDB)
        }
        return nil
    }
    
    static func getFavorites() -> [MovieViewModel] {
        var moviesView: [MovieViewModel] = []
        for movie in Movie.getFavorites() {
            moviesView.append(MovieViewModel.movieAsView(movie))
        }
        return moviesView
    }
}
