//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 2.5
        posterImage.layer.masksToBounds = true
    }
    
    func bind(_ movie: MovieViewModel) {
        if let url = movie.posterURL {
            self.posterImage.setImage(with: url, placeholder: Asset.moviePosterPlaceholder.image)
        }
    }
}
