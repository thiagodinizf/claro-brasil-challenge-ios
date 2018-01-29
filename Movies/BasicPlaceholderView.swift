//
//  BasicPlaceholderView.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit
import StatefulViewController

class BasicPlaceholderView: UIView, StatefulPlaceholderView {
    
    var topOffset: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    func configure() { }
    
    func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
    }
}
