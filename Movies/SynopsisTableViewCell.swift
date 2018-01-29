//
//  SynopsisTableViewCell.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class SynopsisTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var overview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.overview.textColor = ColorName.secondaryText.color
        self.contentView.backgroundColor = ColorName.background.color
        self.isUserInteractionEnabled = false
    }
    
    func bind(movie: MovieViewModel) {
        self.overview.text = movie.overviewText
    }
}
