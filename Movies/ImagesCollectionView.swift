//
//  ImagesCollectionView.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class ImagesCollectionView: UITableViewCell, NibReusable {

    @IBOutlet var collectionView: UICollectionView!
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupCollection()
    }

    func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ImageCollectionViewCell.self)
        collectionView.backgroundColor = UIColor.clear
    }
}

extension ImagesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImageCollectionViewCell.self)
        let image = self.images[indexPath.item]
        cell.bind(string: image)
        return cell
    }
}
