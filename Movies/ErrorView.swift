//
//  ErrorView.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class ErrorView: BasicPlaceholderView, NibOwnerLoadable {
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet var contentView: UIView!
    
    override func configure() {
        self.loadNibContent()
        self.buttonAction.isHidden = true
        self.text.text = "Something went wrong."
        self.contentView.backgroundColor = UIColor.white
    }
}
