//
//  MovieSectionType.swift
//  Movies
//
//  Created by Thiago Diniz on 28/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation

enum MovieSectionType {
    case overview, images, videos
    
    var title: String {
        switch self {
        case .overview:
            return L10n.Movie.sectionSynopsis
        case .videos:
            return L10n.Movie.sectionVideos
        case .images:
            return L10n.Movie.sectionImages
        }
    }
    
    static func type(_ section: Int) -> MovieSectionType {
        switch section {
        case 0:
            return .overview
        case 1:
            return .videos
        case 2:
            return .images
        default:
            return .overview
        }
    }
    
    static var count: Int {
        return [.overview, videos, images].count
    }
}
