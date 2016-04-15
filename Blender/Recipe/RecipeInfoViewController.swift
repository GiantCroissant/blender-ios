//
//  RecipeInfoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit
import TTGSnackbar

class RecipeInfoViewController: UIViewController {
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var collectButton: UIButton!
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var ingredientsLabel: UILabel!
  @IBOutlet weak var stepsLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  var recipe: Recipe!

  override func viewDidLoad() {
    recipeTitle.text = recipe.title
    recipeImage.image = UIImage(named: recipe.image)
    ingredientsLabel.text = recipe.getIngredients()
    stepsLabel.text = recipe.getSteps()
    descriptionLabel.text = recipe.description
    configureCollectButtonIcon()
  }

  @IBAction func onCollect(sender: AnyObject) {
    RecipeManager.sharedInstance.collectRecipe(recipe.id)
    configureCollectButtonIcon()

    let collected = RecipeManager.sharedInstance.isCollected(recipe.id)
    let message = recipe.title + (collected ? " 已加入收藏" : " 已取消收藏")
    TTGSnackbar.init(message: message, duration: TTGSnackbarDuration.Short).show()
  }

  func configureCollectButtonIcon() {
    let collected = RecipeManager.sharedInstance.isCollected(recipe.id)
    let imageName = collected ? "collect_y" : "collect_n"
    collectButton.setImage(UIImage(named: imageName), forState: .Normal)
  }

}

extension Recipe {

  func getIngredients() -> String {
    return ingredients.reduce("") {
      let amount = ($1.exactMeasurement ? $1.amount : $1.suggestedMeasurement)
      return $0 + $1.name + "" + amount + "\n"
      }
      .cutLast(2)
  }

  func getSteps() -> String {
    var counter = 0
    return steps.reduce("") {
      counter += 1
      return $0 + String(counter) + " " + $1.action + "\n"
      }.cutLast(2)
  }

}

extension String {

  func cutLast(range: Int) -> String {
    return self[0...self.characters.count - range]
  }

  subscript (r: Range<Int>) -> String {
    get {
      let startIndex = self.startIndex.advancedBy(r.startIndex)
      let endIndex = self.startIndex.advancedBy(r.endIndex)
      return self[startIndex..<endIndex]
    }
  }
}

