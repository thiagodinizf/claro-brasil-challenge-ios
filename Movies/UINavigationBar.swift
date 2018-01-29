//
//  UINavigationController.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setTransparentBar() {
        let img = UIImage()
        self.shadowImage = img
        self.setBackgroundImage(img, for: .default)
        self.isTranslucent = true
    }
}
