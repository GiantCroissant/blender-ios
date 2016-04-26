//
//  ProductViewController.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

  var product = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    product.append("營養調理機")
    product.append("食物料理加工機")
    product.append("電鍋")
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let cell = sender as? ProductCategoryCell {
      let vc = segue.destinationViewController as! ProductListViewController
      vc.category = cell.title.text!
    }
  }

}

extension ProductViewController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return product.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("product_category_cell", forIndexPath: indexPath) as! ProductCategoryCell
    cell.title.text = product[indexPath.row]

    let customBgView = UIView()
    customBgView.backgroundColor = UIColor(rgba: "#8cc34b33")
    cell.selectedBackgroundView = customBgView
    return cell
  }

}


class ProductCategoryCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!

}
