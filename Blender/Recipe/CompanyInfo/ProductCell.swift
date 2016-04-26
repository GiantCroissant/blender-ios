//
//  ProductCell.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
  @IBOutlet weak var productImg: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var descriptions: UILabel!

  var product: Product! {
    didSet {
      title.text = product.title
      descriptions.text = product.getDescriptionTitles()
      productImg.image = UIImage(named: product.imageName)
    }
  }
}


extension Product {
  func getDescriptionTitles() -> String {
    return descriptions.reduce("") {
      return $0 + $1.title + "\n"
    }
  }
}

