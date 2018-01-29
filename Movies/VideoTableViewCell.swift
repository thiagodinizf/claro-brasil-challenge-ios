//
//  VideoTableViewCell.swift
//  Movies
//
//  Created by Thiago Diniz on 28/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

protocol PlayVideoDelegate {
    
    func didClickPlayVideo(url: URL)
}

class VideoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var playButton: UIButton!
    
    var url: URL!
    
    var delegate: PlayVideoDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ColorName.background.color
        self.selectionStyle = .none
        playButton.layer.cornerRadius = 5
        playButton.layer.masksToBounds = true
    }

    func bind(movie: MovieViewModel, delegate: PlayVideoDelegate) {
        self.delegate = delegate
        self.url = movie.trailerURL!
        if let url = movie.trailerThumbnail {
            self.playButton.setImage(with: url)
        }
    }
    
    @IBAction func play(_ sender: Any) {
        self.delegate.didClickPlayVideo(url: self.url)
    }
}
