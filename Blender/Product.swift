//
//  Product.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Gloss

struct Products: Glossy {
  let products: [Product]

  init?(json: JSON) {
    self.products = "products" <~~ json ?? [Product]()
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct Product: Glossy {
  let id: String
  let title: String
  let category: String
  let imageName: String
  let descriptions: [ProductDescription]
  let infos: [ProductInfo]
  let specs: [ProductSpecs]

  init?(json: JSON) {
    self.id = "id" <~~ json ?? ""
    self.title = "title" <~~ json ?? ""
    self.category = "category" <~~ json ?? ""
    self.imageName = "imageName" <~~ json ?? ""
    self.descriptions = "descriptions" <~~ json ?? [ProductDescription]()
    self.infos = "infos" <~~ json ?? [ProductInfo]()
    self.specs = "specs" <~~ json ?? [ProductSpecs]()
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct ProductDescription: Glossy {
  let title: String
  let desc: String

  init?(json: JSON) {
    self.title = "title" <~~ json ?? ""
    self.desc = "desc" <~~ json ?? ""
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct ProductInfo: Glossy {
  let title: String
  let desc: String

  init?(json: JSON) {
    self.title = "title" <~~ json ?? ""
    self.desc = "desc" <~~ json ?? ""
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct ProductSpecs: Glossy {
  let title: String
  let desc: String

  init?(json: JSON) {
    self.title = "title" <~~ json ?? ""
    self.desc = "desc" <~~ json ?? ""
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

