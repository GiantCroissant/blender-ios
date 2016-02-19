//
//  RecipeVideoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class RecipeVideoViewController: UIViewController {
  @IBOutlet weak var player: YTPlayerView!

  var recipe: Recipe!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = recipe.title
    player.loadWithVideoId(recipe.videoCode)
  }
}
