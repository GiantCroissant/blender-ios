//
//  ProductCell.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var descriptions: UILabel!

  var product: Product! {
    didSet {
      title.text = product.title
//      descriptions.text = product.
    }
  }
}
