//
//  RecipeInfoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeInfoViewController: UIViewController {
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var collectButton: UIButton!
  @IBOutlet weak var recipeImage: UIImageView!

  var recipe: Recipe!

  override func viewDidLoad() {
    recipeTitle.text = recipe.title
    recipeImage.image = UIImage(named: recipe.image)
  }

}
