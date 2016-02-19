//
//  RecipeManager.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Foundation
import Gloss

class RecipeManager {
  static let sharedInstance = RecipeManager()

  private let userDefaults = NSUserDefaults.standardUserDefaults()
  private var collectionIds = [String]()
  private var recipes = [Recipe]()

  init() {
    if userDefaults.arrayForKey("collection") == nil {
      updateUserDefaults()
    }
    collectionIds = userDefaults.arrayForKey("collection") as! [String]

    if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
      do {
        let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
        if let recipeCollection = RecipeCollections(json: jsonResult as! JSON) {
          self.recipes = recipeCollection.recipes
        }
      } catch {
        print(error)
      }
    } else {
      print("data.json not found!")
    }
  }

  func getCollectionRecipeIds() -> [String] {
    return collectionIds
  }

  func getCollectionRecipes() -> [Recipe] {
    return recipes.filter { collectionIds.contains($0.id) }
  }

  func collectRecipe(recipeId: String) {
    if collectionIds.contains(recipeId) {
      collectionIds.removeObject(recipeId)
      updateUserDefaults()

    } else {
      collectionIds.append(recipeId)
      updateUserDefaults()
    }
  }

  func isCollected(recipeId: String) -> Bool {
    return collectionIds.contains(recipeId)
  }

  private func updateUserDefaults() {
    userDefaults.setObject(collectionIds, forKey: "collection")
  }

  func loadRecentRecipes() -> [Recipe] {
    return recipes
  }

  func loadFakeHotRecipes() -> [Recipe] {
    return recipes.sort { $0.viewedCount > $1.viewedCount }
  }

  func loadRecords() -> [Record] {
    
    return [Record]()
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