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
  @IBOutlet weak var productId: UILabel!
  @IBOutlet weak var productInfos: UILabel!
  @IBOutlet weak var productSpecs: UILabel!
  @IBOutlet weak var productDescriptions: UILabel!

  var product: Product!

  override func viewDidLoad() {
    super.viewDidLoad()

    productImage.image = UIImage(named: product.imageName)
    productId.text = product.id
    productInfos.text = product.getInfos()
    productSpecs.text = product.getSpecs()
    productDescriptions.text = product.getDescriptions()
  }

}


extension Product {

  func getInfos() -> String {
    return infos.reduce("") {
      return $0 + $1.title + " : " + $1.desc + "\n"
    }
  }

  func getSpecs() -> String {
    return specs.reduce("") {
      return $0 + $1.title + " : " + $1.desc + "\n"
    }
  }

  func getDescriptions() -> String {
    return descriptions.reduce("") {
      return $0 + $1.title + " : " + "\n" + $1.desc + "\n\n"
    }
  }
}

