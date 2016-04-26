//
//  ProductListViewController.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController {
  var category: String = ""
  var products = [Product]()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = category

    products = ProductManager.sharedInstance.loadProductsByCategory(category)
    print("products = \(products)")
  }

/*
   @available(iOS 2.0, *)
   public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int

   // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
   // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

   @available(iOS 2.0, *)
   public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

 */

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) as! RecipeCell
    cell.recipe = recipes[indexPath.row]
    return cell
  }

}
