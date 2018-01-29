//
//  ItemSize.swift
//  Movies
//
//  Created by Thiago Diniz on 28/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit

class ItemSize {
    
    static let preferedPosterWidhPoints: CGFloat = 342.0/UIScreen.main.scale
    static let insets: CGFloat = 8
    static let posterAspectRatio: CGFloat = 0.667
    
    static func posterWidthForPath() -> String {
        if currentDevice.isPad {
            return "w500"
        } else {
            return "w342"
        }
    }
    
    static func backdropWidthForPath() -> String {
        if currentDevice.isPad {
            return "w780"
        } else {
            return "w300"
        }
    }
    
    static func youtubeThumbnailQuality() -> String {
        return "hqdefault.jpg"
    }
    
    static func collectionViewItemSize() -> CGSize {
        let numberOfItemsInRow: CGFloat = self.numberOfItemsInRow()
        let width = (UIScreen.main.bounds.width/numberOfItemsInRow) - (2 * insets)
        let height = width/posterAspectRatio
        return CGSize(width: width, height: height)
    }
    
    static func detailItemSize() -> CGSize {
        let width = self.width()/2
        let height = width/posterAspectRatio
        return CGSize(width: width, height: height)
    }
    
    static func itemInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets+2, bottom: insets, right: insets+2)
    }
    
    static func width() -> CGFloat {
        let width = UIScreen.main.nativeBounds.width
        let point = width / UIScreen.main.nativeScale
        return point
    }
    
    static func height() -> CGFloat {
        let height = UIScreen.main.nativeBounds.height
        let point = height / UIScreen.main.nativeScale
        return point
    }
    
    private static func numberOfItemsInRow() -> CGFloat {
        return CGFloat(Int(UIScreen.main.bounds.width/preferedPosterWidhPoints))
    }
}
