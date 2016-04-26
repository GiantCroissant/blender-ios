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
}
