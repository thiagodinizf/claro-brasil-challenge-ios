//
//  EmptyView.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable

class EmptyView: BasicPlaceholderView, NibOwnerLoadable {
    
    @IBOutlet weak var emptyText: UILabel!
    @IBOutlet var contentView: UIView!
    
    required init(frame: CGRect, emptyMessage: String? = nil) {
        super.init(frame: frame)
        if let emptyMessage = emptyMessage {
            self.emptyText.text = emptyMessage
        } else {
            self.emptyText.text = L10n.Default.noContent
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func configure() {
        self.loadNibContent()
        self.contentView.backgroundColor = ColorName.background.color
    }
}
