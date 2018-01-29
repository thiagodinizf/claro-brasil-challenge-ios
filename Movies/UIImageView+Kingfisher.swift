//
//  UIImage+Kingfisher.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(with url: URL!, placeholder: UIImage? = nil) {
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
        self.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
    }
    
    func setImageBlur(with url: URL?, placeholder: UIImage? = nil, radius: CGFloat? = nil) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill) >> BlurImageProcessor(blurRadius: radius ?? 10.0)
        self.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.5))])
    }
    
    private func setRounded(border: Bool = true) {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
        if border {
            self.layer.borderWidth = 0.5
            self.layer.borderColor = ColorName.secondaryText.color.cgColor
        }
    }

    func setImageRounded(with url: URL? = nil, placeholder: UIImage? = nil, border: Bool = true) {
        self.setRounded(border: border)
        if let url = url {
            let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
            self.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
        } else {
            self.image = placeholder
        }
    }
}

extension UIButton {
    
    func setImage(with url: URL!, placeholder: UIImage? = nil) {
        self.layer.masksToBounds = true
        self.imageView?.contentMode = .scaleAspectFill
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
        self.kf.setImage(with: url, for: .normal, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
    }
}
