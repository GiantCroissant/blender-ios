//
//  ViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var youTubePlayer: YTPlayerView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

//        youTubePlayer.loadWithVideoId("M7lc1UVf-VE", playerVars: ["playsinline" : 1])
    }

}

