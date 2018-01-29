//
//  LoadingView.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//


import UIKit
import SpringIndicator
import Reusable

class LoadingView: BasicPlaceholderView, NibOwnerLoadable {
    
    @IBOutlet weak var loading: SpringIndicator!
    @IBOutlet var contentView: UIView!
    
    override func configure() {
        self.loadNibContent()

        self.contentView.backgroundColor = ColorName.background.color
        
        loading.configure()
        loading.start()
    }
}
