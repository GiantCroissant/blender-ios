//
//  ProductInfoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class ProductInfoViewController: UIViewController {
  @IBOutlet weak var productImage: UIImageView!

  var product: Product!

  override func viewDidLoad() {
    super.viewDidLoad()

    productImage.image = UIImage(named: product.imageName)
  }

}
