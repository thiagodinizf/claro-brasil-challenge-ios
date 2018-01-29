//
//  ImageCollectionViewCell.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class ImageCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }
    
    func bind(string: String) {
        if let url = URL(string: string) {
            self.imageView.setImage(with: url)
        }
    }
}
