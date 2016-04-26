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
    productDescriptions.attributedText = product.getAttributedDescriptions();
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

  func getAttributedDescriptions() -> NSMutableAttributedString {
    let descs = NSMutableAttributedString()

    let titleAttrs = [
      NSForegroundColorAttributeName: UIColor(rgba: "#336900"),
      NSFontAttributeName: UIFont.systemFontOfSize(14)
    ]

    let descAttrs = [
      NSForegroundColorAttributeName: UIColor(rgba: "#4d4d4e"),
      NSFontAttributeName: UIFont.systemFontOfSize(12)
    ]

    descriptions.forEach { desc in

      let title = NSAttributedString(string: desc.title + " : \n", attributes: titleAttrs)
      descs.appendAttributedString(title)

      let content = NSAttributedString(string: desc.desc + "\n\n", attributes: descAttrs)
      descs.appendAttributedString(content)

    }

    return descs;
  }
}

