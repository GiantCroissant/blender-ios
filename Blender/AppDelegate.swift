//
//  AppDelegate.swift
//  Blender
//
//  Created by Bryan Lin on 7/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {


    let ids = RecipeManager.sharedInstance.getCollectionRecipeIds()
    print("collection ids = \(ids)")
    RecipeManager.sharedInstance.collectRecipe(1)
    RecipeManager.sharedInstance.collectRecipe(1)
    RecipeManager.sharedInstance.collectRecipe(1)
    RecipeManager.sharedInstance.collectRecipe(2)
    RecipeManager.sharedInstance.collectRecipe(3)

    setupCustomNavigationBarColor()
    setupCustomStatusBarColor()
    return true
  }

  func setupCustomNavigationBarColor() {
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.barStyle = UIBarStyle.Black
    navigationBarAppearace.tintColor = UIColor.whiteColor()
    navigationBarAppearace.barTintColor = UIColor(rgba: "#7db343")
  }

  func setupCustomStatusBarColor() {

    //        var statusBar = UIView()
    //        statusBar.frame = CGRectMake(0, 0, 320, 20)
    //        statusBar.backgroundColor = UIColor(rgba: "#7db343")
    //        self.window?.rootViewController?.view.addSubview(statusBar)

    let view = UIView(frame:
      CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
    )
    view.backgroundColor = UIColor(rgba: "#336900")
    self.window?.rootViewController?.view.addSubview(view)

    //      self.revealViewController().view.addSubview(view)

    let application = UIApplication.sharedApplication()
    application.setStatusBarStyle(.LightContent, animated: true)
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

