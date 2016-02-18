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
  private var collectionIds: [Int]

  init() {
    if userDefaults.arrayForKey("collection") == nil {
      let emptyCollection = [Int]()
      userDefaults.setObject(emptyCollection, forKey: "collection")
      print("adding empty collection")
    }
    collectionIds = userDefaults.arrayForKey("collection") as! [Int]
  }

  func getCollectionRecipeIds() -> [Int] {
    return collectionIds
  }

  func saveCollection(recipeId recipeId: Int) {
    collectionIds.append(recipeId)
    userDefaults.setObject(collectionIds, forKey: "collection")
    print("collection saved: \(recipeId)")
  }
  
}