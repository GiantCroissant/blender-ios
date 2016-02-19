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
      counter++
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
      return self[Range(start: startIndex, end: endIndex)]
    }
  }
}

