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
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("product_cell", forIndexPath: indexPath) as! ProductCell
    cell.product = products[indexPath.row]
    return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let cell = sender as? ProductCell {
      let vc = segue.destinationViewController as! ProductInfoViewController
      vc.product = cell.product
    }
  }

}

