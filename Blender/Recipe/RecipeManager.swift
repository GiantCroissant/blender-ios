//
//  RecipeManager.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Foundation

class RecipeManager {
  static let sharedInstance = RecipeManager()

  private let userDefaults = NSUserDefaults.standardUserDefaults()
  private var collectionIds = [Int]()

  init() {
    if userDefaults.arrayForKey("collection") == nil {
      updateUserDefaults()
    }
    collectionIds = userDefaults.arrayForKey("collection") as! [Int]
  }

  func getCollectionRecipeIds() -> [Int] {
    return collectionIds
  }

  func collectRecipe(recipeId: Int) {
    if collectionIds.contains(recipeId) {
      collectionIds.removeObject(recipeId)
      updateUserDefaults()

    } else {
      collectionIds.append(recipeId)
      updateUserDefaults()
    }
  }

  private func updateUserDefaults() {
    userDefaults.setObject(collectionIds, forKey: "collection")
  }

}

// Swift 2 Array Extension
extension Array where Element: Equatable {

  mutating func removeObject(object: Element) {
    if let index = self.indexOf(object) {
      self.removeAtIndex(index)
    }
  }

  mutating func removeObjectsInArray(array: [Element]) {
    for object in array {
      self.removeObject(object)
    }
  }
}