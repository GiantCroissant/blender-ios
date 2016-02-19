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
  private var records = [Record]()

  init() {
    collectionIds = userDefaults.arrayForKey("collection") as? [String] ?? [String]()
    records = unarchiveRecords()
    recipes = readRecipesFromBundleJson()
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
    return records
  }

  func saveRecord(recipe: Recipe) {
    let newRecord = Record(title: recipe.title, date: NSDate().stringFormattedAsRFC3339)
    records.append(newRecord)
    records.sortInPlace { $0.date.toNSDate() > $1.date.toNSDate() }

    let encodedRecords = NSKeyedArchiver.archivedDataWithRootObject(records)
    userDefaults.setObject(encodedRecords, forKey: "record")
  }

  func unarchiveRecords() -> [Record] {
    if let encodedRecords = userDefaults.objectForKey("record") as? NSData {
      let deCodedRecords = NSKeyedUnarchiver.unarchiveObjectWithData(encodedRecords) as! [Record]
      return deCodedRecords.sort { $0.date.toNSDate() > $1.date.toNSDate() }
    }
    return [Record]()
  }

  func readRecipesFromBundleJson() -> [Recipe] {
    if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
      do {
        let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
        if let recipeCollection = RecipeCollections(json: jsonResult as! JSON) {
          return recipeCollection.recipes
        }
      } catch {
        print(error)
      }
    } else {
      print("data.json not found!")
    }

    return [Recipe]()
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