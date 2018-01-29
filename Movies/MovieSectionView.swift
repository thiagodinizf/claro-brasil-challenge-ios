//
//  MovieSectionView.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class MovieSectionView: UIView, NibOwnerLoadable {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(frame: CGRect, title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        self.configure()
        self.titleLabel.text = title
    }
    
    func configure() {
        self.loadNibContent()
        self.titleLabel.textColor = .white
        self.contentView.backgroundColor = ColorName.background.color
    }
}
