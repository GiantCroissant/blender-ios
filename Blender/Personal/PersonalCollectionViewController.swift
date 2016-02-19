//
//  PersonalCollectionViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class PersonalCollectionViewController: UITableViewController {
  @IBOutlet var collectionsTableView: UITableView!

  var collections: [Recipe]!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionsTableView.rowHeight = UITableViewAutomaticDimension
    collectionsTableView.estimatedRowHeight = 100
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    collections = RecipeManager.sharedInstance.getCollectionRecipes()
    collectionsTableView.reloadData()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detail" {
      let cell = sender as! CollectionCell
      let vc = segue.destinationViewController as! RecipeDetailsViewController
      vc.recipe = cell.recipe
    }
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collections.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionCell

    let bgColor = indexPath.row % 2 == 0 ? UIColor(rgba: "#fafafa") : UIColor.whiteColor()
    let recipe = collections[indexPath.row]
    cell.recipe = recipe
    cell.cellBackground.backgroundColor = bgColor
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      let refreshAlert = UIAlertController(title: "刪除收藏", message: "確定要刪除此筆收藏？", preferredStyle: .Alert)
      refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default) { _ in
        let recipe = self.collections[indexPath.row]
        self.collections.removeAtIndex(indexPath.row)
        RecipeManager.sharedInstance.collectRecipe(recipe.id)
        tableView.reloadData()
      })
      refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default) { _ in })
      presentViewController(refreshAlert, animated: true, completion: nil)
    }
  }

}


class CollectionCell: UITableViewCell {
  @IBOutlet weak var cellBackground: UIView!
  @IBOutlet weak var recipeTitle: UILabel!

  var recipe: Recipe! {
    didSet {
      recipeTitle.text = recipe.title
    }
  }
}


