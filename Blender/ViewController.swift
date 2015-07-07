//
//  ViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var youTubePlayer: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        youTubePlayer.loadWithVideoId("M7lc1UVf-VE", playerVars: ["playsinline" : 1])
    }

}

