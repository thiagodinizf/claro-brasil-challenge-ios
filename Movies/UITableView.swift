//
//  UITableView.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ColorName.background.color
    }
    
    func reloadDataWithAnimation() {
        self.beginUpdates()
        let range = NSMakeRange(0, self.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.reloadSections(sections as IndexSet, with: .automatic)
        self.endUpdates()
    }
}

extension UICollectionView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ColorName.background.color
    }
    
    func reloadDataWithAnimation() {
        let range = Range(uncheckedBounds: (0, self.numberOfSections))
        let indexSet = IndexSet(integersIn: range)
        self.reloadSections(indexSet)
    }
}
