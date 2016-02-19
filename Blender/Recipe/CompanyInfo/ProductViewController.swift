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
    product.append("專業養生調理機")
  }

}

extension ProductViewController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return product.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! ProdcutCell
    cell.title.text = product[indexPath.row]
    return cell
  }

}

class ProdcutCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!

}
