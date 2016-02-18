//
//  RecipeTableViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

  enum ListType {
    case Recent
    case Hot
  }
  var listType: ListType!
  var recipes = [Recipe]()

  override func viewDidLoad() {
    super.viewDidLoad()

    if listType == .Recent {
      recipes = RecipeManager.sharedInstance.loadRecentRecipes()
    }

    if listType == .Hot {
      recipes = RecipeManager.sharedInstance.loadFakeHotRecipes()
    }

  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) as! RecipeCell
    cell.recipe = recipes[indexPath.row]
    return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "recipe_detail" {
      let cell = sender as! RecipeCell
      let vc = segue.destinationViewController as! RecipeDetailsViewController
      vc.recipe = cell.recipe
    }
  }
}


class RecipeCell: UITableViewCell {
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var title: UILabel!

  var recipe: Recipe! {
    didSet {
      recipeImage.image = UIImage(named: recipe.image)
      title.text = recipe.title
    }
  }

  override func setHighlighted(highlighted: Bool, animated: Bool) {
    if (highlighted) {
      UIView.animateWithDuration(0.1) {
        self.transform = CGAffineTransformMakeScale(0.95, 0.95)
        self.alpha = 0.8
      }

    } else {
      UIView.animateWithDuration(0.1) {
        self.transform = CGAffineTransformMakeScale(1, 1)
        self.alpha = 1.0
      }
    }
  }

}
