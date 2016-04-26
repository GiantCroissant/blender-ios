//
//  Recipe.swift
//  Blender
//
//  Created by Bryan Lin on 2/17/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Gloss

struct RecipeCollections: Glossy {
  let recipes: [Recipe]

  init?(json: JSON) {
    self.recipes = "recipesCollection" <~~ json ?? [Recipe]()
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct Recipe: Glossy {
  let id: String
  let title: String
  let category: String
  let image: String
  let viewedCount: Int
  let description: String
  let videoCode: String
  let steps: [Step]
  let ingredients: [Ingredient]

  init?(json: JSON) {
    self.id = "id" <~~ json ?? ""
    self.title = "title" <~~ json ?? ""
    self.category = "category" <~~ json ?? ""
    self.image = "image" <~~ json ?? ""
    self.viewedCount = "viewedCount" <~~ json ?? 0
    self.description = "description" <~~ json ?? ""
    self.videoCode = "videoCode" <~~ json ?? ""
    self.steps = "steps" <~~ json ?? [Step]()
    self.ingredients = "ingredients" <~~ json ?? [Ingredient]()
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct Ingredient: Glossy {
  let name: String
  let exactMeasurement: Bool
  let amount: String
  let unit: String
  let suggestedMeasurement: String

  init?(json: JSON) {
    self.name = "name" <~~ json ?? ""
    self.exactMeasurement = "exactMeasurement" <~~ json ?? false
    self.amount = "amount" <~~ json ?? ""
    self.unit = "unit" <~~ json ?? ""
    self.suggestedMeasurement = "suggestedMeasurement" <~~ json ?? ""
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct Step: Glossy {
  let action: String
  let machineAction: MachineAction?
  let note: String?

  init?(json: JSON) {
    self.action = "action" <~~ json ?? ""
    self.machineAction = "machineAction" <~~ json
    self.note = "note" <~~ json
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

struct MachineAction: Glossy {
  let speed: Int
  let time: Int

  init?(json: JSON) {
    self.speed = "speed" <~~ json ?? 1
    self.time = "time" <~~ json ?? 1
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}
