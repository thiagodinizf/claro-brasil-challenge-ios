//
//  MovieHeaderView.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

protocol FavoriteDelegate {
    
    func didSelectFavorite(isSelected: Bool)
}

class MovieHeaderView: UIView, NibOwnerLoadable {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    @IBOutlet weak var posterWidth: NSLayoutConstraint!
    
    var delegate: FavoriteDelegate!
    
    let gradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    
    required init(frame: CGRect, movie: MovieViewModel, delegate: FavoriteDelegate) {
        super.init(frame: CGRect(x: 0, y: 0, width: ItemSize.width(), height: ItemSize.width()+50 ))
        self.loadNibContent()
        self.setupAppearance()
        self.delegate = delegate
        self.titleLabel.text = movie.titleText.uppercased()
        self.subtitleLabel.text = movie.releaseDate
        if let url = movie.posterURL {
            self.backdrop.setImageBlur(with: url)
            self.posterImage.setImage(with: url)
        }
        favoriteButton.isSelected = movie.movie.favorite
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    func setupAppearance() {
        self.loadNibContent()
        self.contentView.backgroundColor = .clear
        self.subtitleLabel.textColor = ColorName.secondaryText.color
        self.setGradientInBackImage()

        self.posterImage.layer.cornerRadius = 5
        self.posterImage.layer.masksToBounds = true
        self.posterImage.layer.shadowRadius = 1
        self.posterImage.layer.shadowColor = UIColor.black.cgColor
        self.posterImage.layer.shadowOpacity = 0.3
        self.posterImage.layer.shadowOffset = CGSize(width:1, height:1)
        
        self.favoriteButton.setImage(Asset.heartOutlineFilled.image, for: .selected)
        self.favoriteButton.setImage(Asset.heartOutline.image, for: .normal)
        self.favoriteButton.tintColor = .white
        
        self.posterWidth.constant = ItemSize.detailItemSize().width
        self.posterHeight.constant = ItemSize.detailItemSize().height
    }
    
    func setGradientInBackImage() {
        let colorBottom = ColorName.background.color.cgColor
        let colorTop = UIColor.clear.cgColor
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        self.backdrop.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate.didSelectFavorite(isSelected: sender.isSelected)
    }
}
