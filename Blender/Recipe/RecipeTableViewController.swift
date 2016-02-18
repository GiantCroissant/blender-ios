//
//  RecipeTableViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

  var recipes = [Recipe]()


  override func viewDidLoad() {
    super.viewDidLoad()

    // custom UI
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)

    // load recipe datas
    recipes = RecipeManager.sharedInstance.loadRecipes()
  }

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath)

    // Configure the cell...
    print(recipes[indexPath.row].title)

    return cell
  }

}
