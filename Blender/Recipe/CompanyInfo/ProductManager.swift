//
//  ProductManager.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Foundation
import Gloss

class ProductManager {
  static let sharedInstance = ProductManager()

  private var products = [Product]()

  init() {
    products = readProductsFromBundleJson()
    print("products = \(products)")
  }

  func readProductsFromBundleJson() -> [Product] {
    if let path = NSBundle.mainBundle().pathForResource("products", ofType: "json") {
      do {
        let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
        if let products = Products(json: jsonResult as! JSON) {
          return products.products
        }
      } catch {
        print(error)
      }
    } else {
      print("data.json not found!")
    }

    return [Product]()
  }
  
}