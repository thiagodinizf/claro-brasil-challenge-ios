//
//  PlayerView.swift
//  Movies
//
//  Created by Thiago Diniz on 28/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import youtube_ios_player_helper
import Reusable

class PlayerViewController: UIViewController, StoryboardSceneBased {
    
    @IBOutlet weak var player: YTPlayerView!
    
    static var sceneStoryboard = StoryboardScene.Main.storyboard
    
    var key: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let playvarsDic = ["controls": 0, "playsinline": 0, "autohide": 1, "showinfo": 0, "autoplay": 1, "modestbranding": 1]
        player.load(withVideoId: self.key, playerVars: playvarsDic)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
